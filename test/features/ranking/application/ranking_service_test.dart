import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:labhouse/features/ranking/data/openai_repository.dart';
import 'package:labhouse/features/ranking/application/ranking_service.dart';
import 'package:labhouse/features/ranking/domain/ranking_item_model.dart';
import 'package:labhouse/features/ranking/domain/ranking_response_model.dart';

class MockOpenAiRepository extends Mock implements OpenAiRepository {}

class FakeRankingResponse extends Fake implements RankingResponse {}

void main() {
  late RankingService service;
  late MockOpenAiRepository mockOpenAiRepository;
  late ProviderContainer container;

  setUpAll(() {
    registerFallbackValue(FakeRankingResponse());
  });

  setUp(() {
    mockOpenAiRepository = MockOpenAiRepository();
    container = ProviderContainer();
    service = container.read(rankingServiceProvider);
    service.openAiRepository = mockOpenAiRepository;
  });

  tearDown(() {
    container.dispose();
  });

  group('RankingService', () {
    test(
      'getRankingStream returns merged responses from AI repository',
      () async {
        const query = 'test query';
        final mockResponse = RankingResponse(
          query: query,
          topic: 'Test Topic',
          items: [const RankingItem(rank: 1, title: 'Item 1', rating: 4.5)],
          timestamp: DateTime.now(),
          isGenerating: false,
        );

        when(
          () => mockOpenAiRepository.generateRankingStream(
            query: any(named: 'query'),
            offset: any(named: 'offset'),
            limit: any(named: 'limit'),
            previousItems: any(named: 'previousItems'),
          ),
        ).thenAnswer((_) => Stream.fromIterable([mockResponse]));

        final result = await service.getRankingStream(query: query).first;

        expect(result.topic, equals('Test Topic'));
        expect(result.items.length, equals(1));
        expect(result.items.first.title, equals('Item 1'));
      },
    );

    test(
      'loadMoreStream calls generateRankingStream with correct offset',
      () async {
        const query = 'test query';
        final mockResponse = RankingResponse(
          query: query,
          topic: 'Test Topic',
          items: [const RankingItem(rank: 11, title: 'Item 11')],
          timestamp: DateTime.now(),
          isGenerating: false,
        );

        when(
          () => mockOpenAiRepository.generateRankingStream(
            query: query,
            offset: 10,
            limit: 10,
            previousItems: any(named: 'previousItems'),
          ),
        ).thenAnswer((_) => Stream.fromIterable([mockResponse]));

        final result = await service
            .loadMoreStream(query: query, currentCount: 10, additionalItems: 10)
            .first;

        expect(result.items.first.rank, equals(11));
        verify(
          () => mockOpenAiRepository.generateRankingStream(
            query: query,
            offset: 10,
            limit: 10,
            previousItems: any(named: 'previousItems'),
          ),
        ).called(1);
      },
    );
  });
}
