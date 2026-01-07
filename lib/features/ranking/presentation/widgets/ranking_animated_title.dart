import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../ranking_screen_controller.dart';

class RankingAnimatedTitle extends ConsumerWidget {
  final AnimationController titleMoveController;

  const RankingAnimatedTitle({super.key, required this.titleMoveController});

  static const _horizontalPadding = 32.0;
  static const _startTopFraction = 0.4;
  static const _endTop = 10.0;
  static const _hideThreshold = 0.95;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchQuery = ref.watch(
      rankingScreenControllerProvider.select((s) => s.searchQuery),
    );

    return AnimatedBuilder(
      animation: titleMoveController,
      builder: (context, _) {
        if (titleMoveController.value > _hideThreshold) {
          return const SizedBox.shrink();
        }

        final size = MediaQuery.of(context).size;
        final animValue = titleMoveController.value;
        final inverseValue = 1 - animValue;

        final startTop = size.height * _startTopFraction;
        final currentTop = _endTop + (startTop - _endTop) * inverseValue;

        return Positioned(
          top: currentTop,
          left: _horizontalPadding,
          width: size.width - (_horizontalPadding * 2),
          child: Opacity(
            opacity: inverseValue.clamp(0.0, 1.0),
            child: Transform.scale(
              scale: 1.0 + (0.3 * inverseValue),
              alignment: Alignment.center,
              child: _TitleContent(searchQuery: searchQuery),
            ),
          ),
        );
      },
    );
  }
}

class _TitleContent extends StatelessWidget {
  final String searchQuery;

  const _TitleContent({required this.searchQuery});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Ranking for',
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          searchQuery,
          style: AppTextStyles.headlineMedium.copyWith(
            fontWeight: FontWeight.w900,
            color: AppColors.gold,
          ),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
