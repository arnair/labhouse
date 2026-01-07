import '../../domain/ranking_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../ranking_screen_controller.dart';
import 'ranking_dialogs.dart';

class RankingAppBar extends ConsumerWidget {
  final AnimationController titleMoveController;
  final RankingResponse? ranking;

  const RankingAppBar({
    super.key,
    required this.titleMoveController,
    this.ranking,
  });

  static const _height = 56.0;
  static const _showThreshold = 0.95;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchQuery = ref.watch(
      rankingScreenControllerProvider.select((s) => s.searchQuery),
    );

    return SizedBox(
      height: _height,
      child: AnimatedBuilder(
        animation: titleMoveController,
        builder: (context, _) {
          final showAppBar = titleMoveController.value > _showThreshold;
          return Opacity(
            opacity: showAppBar ? 1.0 : 0.0,
            child: _AppBarContent(searchQuery: searchQuery, ranking: ranking),
          );
        },
      ),
    );
  }
}

class _AppBarContent extends StatelessWidget {
  final String searchQuery;
  final RankingResponse? ranking;

  const _AppBarContent({required this.searchQuery, this.ranking});

  @override
  Widget build(BuildContext context) {
    return NavigationToolbar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_rounded),
        onPressed: () => Navigator.pop(context),
      ),
      middle: Text(
        searchQuery,
        style: AppTextStyles.titleMedium.copyWith(fontWeight: FontWeight.bold),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: IconButton(
        icon: const Icon(Icons.info_outline_rounded),
        onPressed: () => RankingDialogs.showCriteriaDialog(context, ranking),
      ),
      centerMiddle: true,
    );
  }
}
