import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/ranking_response_model.dart';
import 'ranking_screen_controller.dart';
import 'widgets/podium_section.dart';
import 'widgets/ranking_dialogs.dart';
import 'widgets/ranking_item_entry.dart';
import 'widgets/ranking_app_bar.dart';
import 'widgets/ranking_animated_title.dart';
import 'widgets/ranking_footer.dart';

class RankingScreen extends ConsumerStatefulWidget {
  final String? query;
  const RankingScreen({super.key, this.query});

  @override
  ConsumerState<RankingScreen> createState() => _RankingScreenState();
}

class _RankingScreenState extends ConsumerState<RankingScreen>
    with TickerProviderStateMixin {
  late final AnimationController _titleController;
  late final AnimationController _listController;
  late final ScrollController _scrollController;
  Timer? _titleDelayTimer;

  RankingScreenController get _controller =>
      ref.read(rankingScreenControllerProvider.notifier);

  @override
  void initState() {
    super.initState();
    Future.microtask(() => _controller.initialize(widget.query));
    _scrollController = ScrollController();
    _setupAnimationControllers();
  }

  void _setupAnimationControllers() {
    _titleController =
        AnimationController(
          duration: const Duration(milliseconds: 800),
          vsync: this,
        )..addStatusListener((status) {
          if (status == AnimationStatus.completed && mounted) {
            _controller.onTitleAnimationCompleted();
          }
        });

    _listController =
        AnimationController(
          duration: const Duration(milliseconds: 800),
          vsync: this,
        )..addStatusListener((status) {
          if (status == AnimationStatus.completed && mounted) {
            _controller.onListAnimationCompleted();
          }
        });

    // Start title animation after fade transition
    _titleDelayTimer = Timer(const Duration(milliseconds: 1000), () {
      if (mounted) _titleController.forward();
    });
  }

  @override
  void dispose() {
    _titleDelayTimer?.cancel();
    _scrollController.dispose();
    _listController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  void _handleRankingStateChanges(
    AsyncValue<RankingResponse?>? previous,
    AsyncValue<RankingResponse?> next,
  ) {
    if (previous == next) return;

    next.whenOrNull(
      data: (response) {
        if (_controller.isEmptyResult(response)) {
          _showDialogSafely(
            () => RankingDialogs.showClarificationDialog(
              context,
              'Empty result from AI',
            ),
          );
        }
      },
      error: (error, _) {
        final resultsError = _controller.getErrorFromException(error);
        if (resultsError != null) {
          _showDialogSafely(
            () => RankingDialogs.showError(
              context,
              type: resultsError.type,
              message: resultsError.message,
              controller: _controller,
            ),
          );
        }
      },
    );
  }

  void _showDialogSafely(VoidCallback showDialog) {
    Future.microtask(() {
      if (mounted) showDialog();
    });
  }

  void _handleScrollNotification(ScrollNotification scrollInfo) {
    final state = ref.read(rankingScreenControllerProvider);

    const loadMoreScrollThreshold = 2000.0;
    final maxScrollExtent = scrollInfo.metrics.maxScrollExtent;
    final currentPixels = scrollInfo.metrics.pixels;
    final isLoading = state.ranking.isLoading;

    if (!isLoading &&
        !state.isLoadingMore &&
        currentPixels >= maxScrollExtent - loadMoreScrollThreshold) {
      _controller.loadMoreItems();
    }
  }

  void _onPodiumAnimationComplete() {
    final state = ref.read(rankingScreenControllerProvider);
    if (!state.listAnimationStarted) {
      _controller.onPodiumAnimationCompleted();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(rankingScreenControllerProvider);
    final ranking = state.ranking.hasValue ? state.ranking.value : null;
    final items = ranking?.items ?? [];

    // Listen for errors or empty results
    ref.listen(
      rankingScreenControllerProvider.select((s) => s.ranking),
      _handleRankingStateChanges,
    );

    // Trigger list animation when ready
    if (items.length > 3 &&
        state.listAnimationStarted &&
        !_listController.isAnimating &&
        !_listController.isCompleted) {
      _listController.forward();
    }

    final topThree = items.take(3).toList();
    final remainingItems = items.skip(3).toList();
    final showRemainingList =
        remainingItems.isNotEmpty && state.listAnimationStarted;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                RankingAppBar(
                  titleMoveController: _titleController,
                  ranking: ranking,
                ),
                Expanded(
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (scrollInfo) {
                      _handleScrollNotification(scrollInfo);
                      return false;
                    },
                    child: CustomScrollView(
                      controller: _scrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      slivers: [
                        // Dynamic spacer for title animation
                        SliverToBoxAdapter(
                          child: AnimatedBuilder(
                            animation: _titleController,
                            builder: (context, _) {
                              final screenHeight = MediaQuery.of(
                                context,
                              ).size.height;
                              final space = _titleController.value < 0.9
                                  ? screenHeight * 0.45
                                  : 20.0;
                              return SizedBox(height: space);
                            },
                          ),
                        ),

                        // Podium section
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: PodiumSection(
                              items: state.isPodiumVisible ? topThree : [],
                              isVisible: state.isPodiumVisible,
                              onAnimationComplete: _onPodiumAnimationComplete,
                            ),
                          ),
                        ),

                        // Remaining items list
                        if (showRemainingList) ...[
                          const SliverToBoxAdapter(child: SizedBox(height: 36)),
                          SliverList.builder(
                            itemCount: remainingItems.length,
                            itemBuilder: (context, index) => RankingItemEntry(
                              item: remainingItems[index],
                              index: index,
                            ),
                          ),
                        ],

                        // Footer
                        if (ranking != null)
                          RankingFooter(
                            ranking: ranking,
                            hasMoreToLoad:
                                items.length < 100 && !ranking.isGenerating,
                            itemCount: items.length,
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            RankingAnimatedTitle(titleMoveController: _titleController),
          ],
        ),
      ),
    );
  }
}
