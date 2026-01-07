import '../../domain/ranking_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../ranking_screen_controller.dart';

class RankingFooter extends ConsumerWidget {
  final RankingResponse ranking;
  final bool hasMoreToLoad;
  final int itemCount;

  const RankingFooter({
    super.key,
    required this.ranking,
    required this.hasMoreToLoad,
    required this.itemCount,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(rankingScreenControllerProvider);
    final controller = ref.read(rankingScreenControllerProvider.notifier);

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 100),
        child: _buildContent(state, controller),
      ),
    );
  }

  Widget _buildContent(
    RankingScreenState state,
    RankingScreenController controller,
  ) {
    if (state.isLoadingMore) {
      return const _LoadingIndicator(message: 'Loading more results...');
    }

    if (ranking.isGenerating) {
      return const _LoadingIndicator();
    }

    if (state.ranking.isLoading) {
      return const _LoadingIndicator(size: 24);
    }

    if (hasMoreToLoad) {
      return const _LoadingIndicator(size: 20, strokeWidth: 2);
    }

    return const SizedBox.shrink();
  }
}

class _LoadingIndicator extends StatelessWidget {
  final String? message;
  final double size;
  final double strokeWidth;

  const _LoadingIndicator({
    this.message,
    this.size = 24,
    this.strokeWidth = 2.5,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: size,
              height: size,
              child: CircularProgressIndicator(
                strokeWidth: strokeWidth,
                color: AppColors.secondary,
              ),
            ),
            if (message != null) ...[
              const SizedBox(height: 12),
              Text(
                message!,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
