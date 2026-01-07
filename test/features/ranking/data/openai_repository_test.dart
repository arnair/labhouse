import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:labhouse/core/errors/ranking_exception.dart';
import 'package:labhouse/features/ranking/data/openai_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

class MockResponse<T> extends Mock implements Response<T> {}

void main() {
  late OpenAiRepository repository;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    // Inject test API key directly, no need for dotenv
    repository = OpenAiRepository(client: mockDio, apiKey: 'test_key');
  });

  group('OpenAiRepository', () {
    group('generateRankingStream', () {
      test('emits RankingResponse updates for valid SSE NDJSON stream', () async {
        final mockResponse = MockResponse<ResponseBody>();

        final sseData = [
          'data: {"choices":[{"delta":{"content":"{\\"topic\\":\\"Movies\\",\\"criteria\\":\\"Rating\\"}\\n"}}]}\n\n',
          'data: {"choices":[{"delta":{"content":"{\\"rank\\":1,\\"title\\":\\"Inception\\",\\"rating\\":9.0}\\n"}}]}\n\n',
          'data: [DONE]\n\n',
        ];

        final stream = Stream.fromIterable(
          sseData.map((s) => Uint8List.fromList(utf8.encode(s))),
        );
        final responseBody = ResponseBody(stream, 200);

        when(() => mockResponse.data).thenReturn(responseBody);
        when(() => mockResponse.statusCode).thenReturn(200);

        when(
          () => mockDio.post(
            any(),
            data: any(named: 'data'),
            options: any(named: 'options'),
          ),
        ).thenAnswer((_) async => mockResponse);

        final results = await repository
            .generateRankingStream(query: 'test')
            .toList();

        // Should have: Initial (Generating...), Topic update, Item 1 update, Final (isGenerating: false)
        expect(results.length, greaterThanOrEqualTo(3));
        expect(results.any((r) => r.topic == 'Movies'), isTrue);
        expect(
          results.any((r) => r.items.any((i) => i.title == 'Inception')),
          isTrue,
        );
        expect(results.last.isGenerating, isFalse);
      });

      test(
        'throws RankingException.safety when AI returns safety error',
        () async {
          final mockResponse = MockResponse<ResponseBody>();
          final sseData = [
            'data: {"choices":[{"delta":{"content":"{\\"error\\":\\"safety\\"}\\n"}}]}\n\n',
            'data: [DONE]\n\n',
          ];

          final stream = Stream.fromIterable(
            sseData.map((s) => Uint8List.fromList(utf8.encode(s))),
          );
          final responseBody = ResponseBody(stream, 200);

          when(() => mockResponse.data).thenReturn(responseBody);
          when(() => mockResponse.statusCode).thenReturn(200);

          when(
            () => mockDio.post(
              any(),
              data: any(named: 'data'),
              options: any(named: 'options'),
            ),
          ).thenAnswer((_) async => mockResponse);

          expect(
            () => repository.generateRankingStream(query: 'test').toList(),
            throwsA(
              isA<RankingException>().having(
                (e) => e.type,
                'type',
                RankingErrorType.safety,
              ),
            ),
          );
        },
      );

      test('throws RankingException.network on Dio connection error', () async {
        when(
          () => mockDio.post(
            any(),
            data: any(named: 'data'),
            options: any(named: 'options'),
          ),
        ).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: ''),
            type: DioExceptionType.connectionError,
          ),
        );

        expect(
          () => repository.generateRankingStream(query: 'test').toList(),
          throwsA(
            isA<RankingException>().having(
              (e) => e.type,
              'type',
              RankingErrorType.network,
            ),
          ),
        );
      });
    });

    group('generateImage', () {
      test('returns URL on successful generation', () async {
        final mockResponse = MockResponse<Map<String, dynamic>>();
        when(() => mockResponse.statusCode).thenReturn(200);
        when(() => mockResponse.data).thenReturn({
          'data': [
            {'url': 'https://example.com/image.png'},
          ],
        });

        when(
          () => mockDio.post(
            any(),
            data: any(named: 'data'),
            options: any(named: 'options'),
          ),
        ).thenAnswer((_) async => mockResponse);

        final result = await repository.generateImage('prompt');
        expect(result, equals('https://example.com/image.png'));
      });

      test('returns null on failure', () async {
        when(
          () => mockDio.post(
            any(),
            data: any(named: 'data'),
            options: any(named: 'options'),
          ),
        ).thenThrow(DioException(requestOptions: RequestOptions(path: '')));

        final result = await repository.generateImage('prompt');
        expect(result, isNull);
      });
    });

    group('RankingException logic', () {
      test(
        'NDJSON line with unknown error throws clarification exception',
        () async {
          final mockResponse = MockResponse<ResponseBody>();
          final sseData = [
            'data: {"choices":[{"delta":{"content":"{\\"error\\":\\"unknown\\"}\\n"}}]}\n\n',
            'data: [DONE]\n\n',
          ];

          final stream = Stream.fromIterable(
            sseData.map((s) => Uint8List.fromList(utf8.encode(s))),
          );
          final responseBody = ResponseBody(stream, 200);

          when(() => mockResponse.data).thenReturn(responseBody);
          when(() => mockResponse.statusCode).thenReturn(200);

          when(
            () => mockDio.post(
              any(),
              data: any(named: 'data'),
              options: any(named: 'options'),
            ),
          ).thenAnswer((_) async => mockResponse);

          expect(
            () => repository.generateRankingStream(query: 'test').toList(),
            throwsA(
              isA<RankingException>().having(
                (e) => e.type,
                'type',
                RankingErrorType.clarification,
              ),
            ),
          );
        },
      );
    });
  });
}
