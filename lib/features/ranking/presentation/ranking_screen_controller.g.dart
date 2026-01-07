// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ranking_screen_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(RankingScreenController)
final rankingScreenControllerProvider = RankingScreenControllerProvider._();

final class RankingScreenControllerProvider
    extends $NotifierProvider<RankingScreenController, RankingScreenState> {
  RankingScreenControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'rankingScreenControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$rankingScreenControllerHash();

  @$internal
  @override
  RankingScreenController create() => RankingScreenController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RankingScreenState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RankingScreenState>(value),
    );
  }
}

String _$rankingScreenControllerHash() =>
    r'05d2a1b31040e86aa878919321d80d2bd9ad107f';

abstract class _$RankingScreenController extends $Notifier<RankingScreenState> {
  RankingScreenState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<RankingScreenState, RankingScreenState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<RankingScreenState, RankingScreenState>,
              RankingScreenState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
