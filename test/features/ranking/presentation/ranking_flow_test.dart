import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:labhouse/core/errors/ranking_exception.dart';
import 'package:labhouse/features/ranking/application/ranking_service.dart';
import 'package:labhouse/features/ranking/data/openai_repository.dart';
import 'package:labhouse/features/ranking/domain/ranking_item_model.dart';
import 'package:labhouse/features/ranking/domain/ranking_response_model.dart';
import 'package:labhouse/features/ranking/presentation/ranking_screen.dart';
import 'package:labhouse/features/ranking/presentation/ranking_screen_controller.dart';
import 'package:labhouse/main.dart';
import 'package:labhouse/widgets/glassy_chip.dart';
import 'package:mocktail/mocktail.dart';

// Mock Repository
class MockOpenAiRepository extends Mock implements OpenAiRepository {}

void main() {
  late MockOpenAiRepository mockOpenAiRepository;

  setUp(() {
    mockOpenAiRepository = MockOpenAiRepository();
    // Global defaults
    when(
      () => mockOpenAiRepository.generateImage(any()),
    ).thenAnswer((_) async => null);
  });

  // Helper to create a testable app with overridden provider
  Widget createTestApp() {
    return ProviderScope(
      overrides: [
        rankingServiceProvider.overrideWith(() {
          final service = RankingService();
          service.openAiRepository = mockOpenAiRepository;
          return service;
        }),
      ],
      child: const RankQuestApp(),
    );
  }

  // Helper to submit query via keyboard action
  Future<void> submitQuery(WidgetTester tester) async {
    await tester.testTextInput.receiveAction(TextInputAction.done);
    // Standardized wait for navigation
    await tester.pump(const Duration(seconds: 1));
    await tester.pump(const Duration(seconds: 1));
    await tester.pump(const Duration(seconds: 1));
  }

  testWidgets('Scenario 1: Happy Path Flow: Home -> Ranking -> Results', (
    WidgetTester tester,
  ) async {
    final List<RankingItem> rankingItems = List.generate(
      5,
      (index) => RankingItem(
        rank: index + 1,
        title: 'Movie ${index + 1}',
        rating: (10 - index).toDouble(),
      ),
    );

    when(
      () => mockOpenAiRepository.generateRankingStream(
        query: any(named: 'query'),
        offset: any(named: 'offset'),
        limit: any(named: 'limit'),
        previousItems: any(named: 'previousItems'),
      ),
    ).thenAnswer(
      (_) => Stream.value(
        RankingResponse(
          query: 'best movies',
          topic: 'Best Movies',
          items: rankingItems,
          timestamp: DateTime.now(),
          totalAvailable: 5,
        ),
      ),
    );

    await tester.pumpWidget(createTestApp());
    await tester.pump(const Duration(seconds: 2));

    await tester.enterText(find.byType(TextField), 'best movies');
    await submitQuery(tester);

    await tester.pump(const Duration(seconds: 6));

    expect(find.byType(RankingScreen), findsOneWidget);
    expect(find.textContaining('Movie 1'), findsWidgets);
  });

  testWidgets('Scenario 2: Error Handling - Safety Exception', (
    WidgetTester tester,
  ) async {
    when(
      () => mockOpenAiRepository.generateRankingStream(
        query: any(named: 'query'),
        offset: any(named: 'offset'),
        limit: any(named: 'limit'),
        previousItems: any(named: 'previousItems'),
      ),
    ).thenAnswer(
      (_) => Stream.error(
        const RankingException(RankingErrorType.safety, 'Inappropriate query'),
      ),
    );

    await tester.pumpWidget(createTestApp());
    await tester.pump(const Duration(seconds: 2));

    await tester.enterText(find.byType(TextField), 'bad words');
    await submitQuery(tester);

    await tester.pump(const Duration(seconds: 3));

    expect(find.text('Unable to Rank'), findsOneWidget);
  });

  testWidgets('Scenario 3: Infinite Scrolling - Load More Items', (
    WidgetTester tester,
  ) async {
    final initialItems = List.generate(
      25,
      (i) => RankingItem(rank: i + 1, title: 'Item ${i + 1}', rating: 5.0),
    );
    final moreItems = List.generate(
      10,
      (i) => RankingItem(rank: 26 + i, title: 'Extra ${i + 1}', rating: 4.0),
    );

    when(
      () => mockOpenAiRepository.generateRankingStream(
        query: any(named: 'query'),
        offset: any(named: 'offset'),
        limit: any(named: 'limit'),
        previousItems: any(named: 'previousItems'),
      ),
    ).thenAnswer((invocation) {
      final offset = invocation.namedArguments[#offset] as int? ?? 0;
      if (offset == 0) {
        return Stream.value(
          RankingResponse(
            query: 'test',
            topic: 'Test',
            items: initialItems,
            timestamp: DateTime.now(),
            totalAvailable: 100,
          ),
        );
      } else {
        return Stream.value(
          RankingResponse(
            query: 'test',
            topic: 'Test',
            items: moreItems,
            timestamp: DateTime.now(),
            totalAvailable: 100,
          ),
        );
      }
    });

    await tester.pumpWidget(createTestApp());
    await tester.pump(const Duration(seconds: 2));
    await tester.enterText(find.byType(TextField), 'test');
    await submitQuery(tester);

    await tester.pump(const Duration(seconds: 6));

    // Find the scrollable and drag it to trigger load more
    final scrollFinder = find.byType(CustomScrollView);
    expect(scrollFinder, findsOneWidget);

    // Drag multiple times to ensure we hit the bottom
    for (int i = 0; i < 5; i++) {
      await tester.drag(scrollFinder, const Offset(0, -2000));
      await tester.pump(const Duration(milliseconds: 500));
    }

    await tester.pump(const Duration(seconds: 3));

    expect(find.textContaining('Extra 1'), findsWidgets);
  });

  testWidgets('Scenario 4: Home Screen Suggestions', (
    WidgetTester tester,
  ) async {
    when(
      () => mockOpenAiRepository.generateRankingStream(
        query: any(named: 'query'),
        offset: any(named: 'offset'),
        limit: any(named: 'limit'),
        previousItems: any(named: 'previousItems'),
      ),
    ).thenAnswer(
      (_) => Stream.value(
        RankingResponse(
          query: 'test',
          topic: 'Test',
          items: [],
          timestamp: DateTime.now(),
        ),
      ),
    );

    await tester.pumpWidget(createTestApp());
    await tester.pump(const Duration(seconds: 2));

    // Scoped finder to avoid hitting TextField hint text
    final suggestionFinder = find
        .descendant(of: find.byType(GlassyChip), matching: find.byType(Text))
        .first;
    expect(suggestionFinder, findsOneWidget);

    await tester.tap(suggestionFinder);
    await tester.pump(const Duration(seconds: 1)); // Transition start
    await tester.pump(const Duration(seconds: 1)); // Animation
    await tester.pump(const Duration(seconds: 3)); // Finalize

    expect(find.byType(RankingScreen), findsOneWidget);
  });

  testWidgets('Scenario 5: Image Generation Flow', (WidgetTester tester) async {
    final initialResponse = RankingResponse(
      query: 'test',
      topic: 'Test',
      items: [const RankingItem(rank: 1, title: 'Item 1', rating: 9.0)],
      timestamp: DateTime.now(),
    );

    when(
      () => mockOpenAiRepository.generateRankingStream(
        query: any(named: 'query'),
        offset: any(named: 'offset'),
        limit: any(named: 'limit'),
        previousItems: any(named: 'previousItems'),
      ),
    ).thenAnswer((_) => Stream.value(initialResponse));

    const generatedUrl = 'https://example.com/image.png';
    when(
      () => mockOpenAiRepository.generateImage(any()),
    ).thenAnswer((_) async => generatedUrl);

    await tester.pumpWidget(createTestApp());
    await tester.pump(const Duration(seconds: 2));
    await tester.enterText(find.byType(TextField), 'test');
    await submitQuery(tester);

    await tester.pump(const Duration(seconds: 6));

    expect(find.textContaining('Item 1'), findsWidgets);

    // Give it time for image generation
    await tester.pump(const Duration(seconds: 6));

    final element = tester.element(find.byType(RankingScreen));
    final controller = ProviderScope.containerOf(
      element,
    ).read(rankingScreenControllerProvider);
    expect(controller.ranking.value?.items.first.imageUrl, generatedUrl);
  });
}
