import '../../domain/ranking_item_model.dart';
import 'package:flutter/material.dart';
import '../../../../widgets/fade_in_entry.dart';
import 'ranking_dialogs.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class RankingItemEntry extends StatelessWidget {
  final RankingItem item;
  final int index;
  final VoidCallback? onTap;

  const RankingItemEntry({
    super.key,
    required this.item,
    required this.index,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInEntry(
      key: ValueKey(item.title),
      delay: Duration(milliseconds: index * 50),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        child: GestureDetector(
          onTap: onTap ?? () => RankingDialogs.showItemDetail(context, item),
          child: RankingCard(item: item),
        ),
      ),
    );
  }
}

/// Card displaying a single ranking item (rank 4+, no images)
class RankingCard extends StatelessWidget {
  const RankingCard({super.key, required this.item});

  final RankingItem item;

  static const _badgeSize = 40.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            _RankBadge(rank: item.rank),
            const SizedBox(width: 16),
            Expanded(child: _buildContent()),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          item.title,
          style: AppTextStyles.titleMedium,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        if (item.rating != null) _buildRating(),
        if (item.description != null) _buildDescription(),
        if (item.location != null) _buildLocation(),
      ],
    );
  }

  Widget _buildRating() {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Row(
        children: [
          RatingBarIndicator(
            rating: item.rating!,
            itemBuilder: (context, _) =>
                const Icon(Icons.star_rounded, color: AppColors.warning),
            itemCount: 5,
            itemSize: 16,
          ),
          const SizedBox(width: 6),
          Text(
            item.rating!.toStringAsFixed(1),
            style: AppTextStyles.labelMedium.copyWith(color: AppColors.warning),
          ),
        ],
      ),
    );
  }

  Widget _buildDescription() {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Text(
        item.description!,
        style: AppTextStyles.bodySmall,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildLocation() {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Row(
        children: [
          const Icon(
            Icons.location_on_outlined,
            size: 14,
            color: AppColors.secondary,
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              item.location!,
              style: AppTextStyles.labelSmall.copyWith(
                color: AppColors.secondary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _RankBadge extends StatelessWidget {
  final int rank;

  const _RankBadge({required this.rank});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: RankingCard._badgeSize,
      height: RankingCard._badgeSize,
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          '$rank',
          style: AppTextStyles.rankNumberSmall.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
