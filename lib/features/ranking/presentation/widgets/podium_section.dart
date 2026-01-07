import 'dart:async';
import '../../domain/ranking_item_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import 'ranking_dialogs.dart';

class PodiumSection extends StatefulWidget {
  final List<RankingItem> items;
  final bool isVisible;
  final VoidCallback? onAnimationComplete;

  const PodiumSection({
    super.key,
    required this.items,
    this.isVisible = false,
    this.onAnimationComplete,
  });

  @override
  State<PodiumSection> createState() => _PodiumSectionState();
}

class _PodiumSectionState extends State<PodiumSection>
    with TickerProviderStateMixin {
  late final AnimationController _fadeController;
  late final AnimationController _podium1Controller;
  late final AnimationController _podium2Controller;
  late final AnimationController _podium3Controller;
  final Set<int> _triggeredRanks = {};
  final List<Timer> _delayedTimers = [];

  static const _animationDuration = Duration(milliseconds: 600);
  static const _fadeDuration = Duration(milliseconds: 400);
  static const _staggerDelay = 300;

  @override
  void initState() {
    super.initState();
    _setupAnimationControllers();
    if (widget.isVisible) _startAnimations();
  }

  void _setupAnimationControllers() {
    _fadeController = AnimationController(duration: _fadeDuration, vsync: this);

    _podium1Controller = AnimationController(
      duration: _animationDuration,
      vsync: this,
    );
    _podium2Controller = AnimationController(
      duration: _animationDuration,
      vsync: this,
    );
    _podium3Controller =
        AnimationController(duration: _animationDuration, vsync: this)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed && mounted) {
              widget.onAnimationComplete?.call();
            }
          });
  }

  @override
  void didUpdateWidget(PodiumSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isVisible) _startAnimations();
  }

  void _startAnimations() {
    if (!_triggeredRanks.contains(0)) {
      _fadeController.forward();
      _triggeredRanks.add(0);
    }

    _revealPodiumItem(1, _podium1Controller, previousController: null);
    _revealPodiumItem(
      2,
      _podium2Controller,
      previousController: _podium1Controller,
    );
    _revealPodiumItem(
      3,
      _podium3Controller,
      previousController: _podium2Controller,
    );
  }

  void _revealPodiumItem(
    int rank,
    AnimationController controller, {
    AnimationController? previousController,
  }) {
    if (widget.items.length < rank || _triggeredRanks.contains(rank)) return;

    _triggeredRanks.add(rank);
    final delay = previousController?.isAnimating == true ? _staggerDelay : 0;

    final timer = Timer(Duration(milliseconds: delay), () {
      if (mounted) controller.forward();
    });
    _delayedTimers.add(timer);
  }

  @override
  void dispose() {
    for (final timer in _delayedTimers) {
      timer.cancel();
    }
    _fadeController.dispose();
    _podium1Controller.dispose();
    _podium2Controller.dispose();
    _podium3Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.items.isEmpty) return const SizedBox.shrink();

    return AnimatedBuilder(
      animation: _fadeController,
      builder: (context, child) =>
          Opacity(opacity: _fadeController.value, child: child),
      child: Container(
        height: 300,
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildPodiumSlot(
              1,
              170,
              '🥈',
              AppColors.silver,
              _podium2Controller,
            ),
            const SizedBox(width: 12),
            _buildPodiumSlot(0, 210, '🥇', AppColors.gold, _podium1Controller),
            const SizedBox(width: 12),
            _buildPodiumSlot(
              2,
              150,
              '🥉',
              AppColors.bronze,
              _podium3Controller,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPodiumSlot(
    int index,
    double height,
    String medal,
    Color color,
    AnimationController controller,
  ) {
    if (widget.items.length <= index) {
      return const SizedBox(width: 110, child: SizedBox.shrink());
    }

    final item = widget.items[index];

    return SizedBox(
      width: 110,
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          final progress = Curves.easeOutBack.transform(
            controller.value.clamp(0.0, 1.0),
          );
          return Opacity(
            opacity: controller.value.clamp(0.0, 1.0),
            child: Transform.scale(
              scale: 0.8 + (0.2 * progress.clamp(0.0, 1.0)),
              child: child,
            ),
          );
        },
        child: GestureDetector(
          onTap: () => RankingDialogs.showItemDetail(context, item),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(medal, style: const TextStyle(fontSize: 36)),
              const SizedBox(height: 8),
              Container(
                width: 110,
                height: height,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      color.withValues(alpha: 0.25),
                      color.withValues(alpha: 0.1),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: color.withValues(alpha: 0.5),
                    width: 2,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Avatar
                    Container(
                      width: 55,
                      height: 55,
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        shape: BoxShape.circle,
                        border: Border.all(color: color, width: 2),
                      ),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 500),
                        child: item.imageUrl != null
                            ? ClipOval(
                                key: ValueKey('podium_image_${item.rank}'),
                                child: CachedNetworkImage(
                                  imageUrl: item.imageUrl!,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Container(
                                    color: color.withValues(alpha: 0.1),
                                    child: Center(
                                      child: SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: color,
                                        ),
                                      ),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) => Icon(
                                    Icons.emoji_events,
                                    key: const ValueKey('podium_icon'),
                                    color: color,
                                    size: 28,
                                  ),
                                ),
                              )
                            : Icon(
                                Icons.emoji_events,
                                key: const ValueKey('podium_icon'),
                                color: color,
                                size: 28,
                              ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Title
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        item.title,
                        style: AppTextStyles.labelMedium.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (item.rating != null) ...[
                      const SizedBox(height: 6),
                      // Rating Badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: color.withValues(alpha: 0.3),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.star_rounded, size: 16, color: color),
                            const SizedBox(width: 4),
                            Text(
                              item.rating!.toStringAsFixed(1),
                              style: AppTextStyles.labelSmall.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
