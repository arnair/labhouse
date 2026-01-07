// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ranking_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Service for ranking operations with pagination support

@ProviderFor(RankingService)
final rankingServiceProvider = RankingServiceProvider._();

/// Service for ranking operations with pagination support
final class RankingServiceProvider
    extends $NotifierProvider<RankingService, RankingService> {
  /// Service for ranking operations with pagination support
  RankingServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'rankingServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$rankingServiceHash();

  @$internal
  @override
  RankingService create() => RankingService();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RankingService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RankingService>(value),
    );
  }
}

String _$rankingServiceHash() => r'04102a84e76c0ab7410f882b38a855116061c5d4';

/// Service for ranking operations with pagination support

abstract class _$RankingService extends $Notifier<RankingService> {
  RankingService build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<RankingService, RankingService>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<RankingService, RankingService>,
              RankingService,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
