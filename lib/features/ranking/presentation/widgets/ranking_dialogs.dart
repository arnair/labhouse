import 'package:flutter/material.dart';
import 'package:labhouse/features/ranking/domain/ranking_response_model.dart';
import 'package:labhouse/features/ranking/domain/ranking_item_model.dart';
import '../../../../core/errors/ranking_exception.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../widgets/app_dialog.dart';
import '../ranking_screen_controller.dart';

/// Centralized dialogs for the ranking feature
class RankingDialogs {
  const RankingDialogs._();

  static void showError(
    BuildContext context, {
    required RankingErrorType type,
    required String message,
    required RankingScreenController controller,
  }) {
    switch (type) {
      case RankingErrorType.network:
        showNetworkErrorDialog(context, message, controller);
      case RankingErrorType.clarification:
        showClarificationDialog(context, message);
      case RankingErrorType.safety:
      case RankingErrorType.inappropriateContent:
        showInappropriateContentDialog(context);
      case RankingErrorType.unknown:
        showGenericErrorDialog(context, message);
    }
  }

  static void showCriteriaDialog(
    BuildContext context,
    RankingResponse? ranking,
  ) {
    showAppDialog(
      context,
      title: 'Ranking Criteria',
      icon: Icons.info_outline_rounded,
      iconColor: AppColors.primary,
      primaryActionText: 'Close',
      child: _CriteriaDialogContent(criteria: ranking?.criteria),
    );
  }

  static void showItemDetail(BuildContext context, RankingItem item) {
    showAppDialog(
      context,
      title: '',
      primaryActionText: 'Close',
      child: _ItemDetailContent(item: item),
    );
  }

  static void showInappropriateContentDialog(BuildContext context) {
    showAppDialog(
      context,
      title: 'Unable to Rank',
      message:
          'We couldn\'t generate a ranking for this topic. It may be inappropriate, '
          'sensitive, or violate our content guidelines. Please try a different topic.',
      icon: Icons.block_rounded,
      iconColor: AppColors.error,
      primaryActionText: 'Go Back',
      barrierDismissible: false,
      onPrimaryAction: () => _popTwice(context),
    );
  }

  static void showNetworkErrorDialog(
    BuildContext context,
    String message,
    RankingScreenController controller,
  ) {
    showAppDialog(
      context,
      title: 'Connection Error',
      message: '$message. Please check your internet connection and try again.',
      icon: Icons.wifi_off_rounded,
      iconColor: AppColors.error,
      primaryActionText: 'Retry',
      barrierDismissible: false,
      onPrimaryAction: () {
        Navigator.pop(context);
        controller.retryQuery();
      },
      secondaryActionText: 'Go Back',
      onSecondaryAction: () => _popTwice(context),
    );
  }

  static void showClarificationDialog(BuildContext context, String message) {
    showAppDialog(
      context,
      title: 'Unknown Topic',
      message:
          'We couldn\'t understand that topic. It might be misspelled or just pure nonsense. '
          'Please try something else.',
      icon: Icons.help_outline_rounded,
      iconColor: AppColors.secondary,
      primaryActionText: 'Try Again',
      barrierDismissible: false,
      onPrimaryAction: () => _popTwice(context),
    );
  }

  static void showGenericErrorDialog(BuildContext context, String message) {
    showAppDialog(
      context,
      title: 'Something Went Wrong',
      message: message,
      icon: Icons.error_outline_rounded,
      iconColor: AppColors.error,
      primaryActionText: 'Close',
      onPrimaryAction: () => Navigator.pop(context),
    );
  }

  static void _popTwice(BuildContext context) {
    Navigator.pop(context);
    if (context.mounted) Navigator.pop(context);
  }
}

class _CriteriaDialogContent extends StatelessWidget {
  final String? criteria;

  const _CriteriaDialogContent({this.criteria});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        _buildSectionTitle('How items are ranked:'),
        const SizedBox(height: 8),
        Text(
          criteria ??
              'Items are ranked based on overall quality, popularity, and relevance to the search query.',
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 20),
        _buildSectionTitle('Star Ratings:'),
        const SizedBox(height: 8),
        _buildRatingRow(5, '5.0', 'Exceptional - Best in class'),
        _buildRatingRow(4, '4.0-4.9', 'Excellent - Highly recommended'),
        _buildRatingRow(3, '3.0-3.9', 'Good - Solid choice'),
        _buildRatingRow(2, '2.0-2.9', 'Fair - Has some drawbacks'),
        _buildRatingRow(1, '1.0-1.9', 'Below average'),
      ],
    );
  }

  Widget _buildSectionTitle(String text) {
    return Text(
      text,
      style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _buildRatingRow(int stars, String range, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          ...List.generate(
            stars,
            (_) => const Icon(Icons.star, size: 14, color: AppColors.gold),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              style: AppTextStyles.labelSmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ItemDetailContent extends StatelessWidget {
  final RankingItem item;

  const _ItemDetailContent({required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),
        const SizedBox(height: 16),
        _buildDescription(),
      ],
    );
  }

  Widget _buildHeader() {
    final rankColor = AppColors.getRankColor(item.rank);

    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [rankColor, rankColor.withValues(alpha: 0.7)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              '#${item.rank}',
              style: AppTextStyles.labelMedium.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            item.title,
            style: AppTextStyles.titleMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        if (item.rating != null) _buildRating(),
      ],
    );
  }

  Widget _buildRating() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.star, color: AppColors.gold, size: 20),
        const SizedBox(width: 4),
        Text(
          item.rating!.toStringAsFixed(1),
          style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildDescription() {
    if (item.description != null && item.description!.isNotEmpty) {
      return Text(
        item.description!,
        style: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.textSecondary,
          height: 1.5,
        ),
      );
    }

    return Text(
      'No description available.',
      style: AppTextStyles.bodyMedium.copyWith(
        color: AppColors.textTertiary,
        fontStyle: FontStyle.italic,
      ),
    );
  }
}
