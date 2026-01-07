import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';

/// Background with gradient and decorative orbs
class GradientBackground extends StatelessWidget {
  const GradientBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
      child: Stack(
        children: [
          const _DecorativeOrb(
            top: -100,
            right: -100,
            size: 300,
            color: AppColors.primary,
          ),
          const _DecorativeOrb(
            bottom: -50,
            left: -50,
            size: 200,
            color: AppColors.secondary,
          ),
          child,
        ],
      ),
    );
  }
}

class _DecorativeOrb extends StatelessWidget {
  final double? top;
  final double? right;
  final double? bottom;
  final double? left;
  final double size;
  final Color color;

  const _DecorativeOrb({
    this.top,
    this.right,
    this.bottom,
    this.left,
    required this.size,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      right: right,
      bottom: bottom,
      left: left,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              color.withValues(alpha: 0.15),
              color.withValues(alpha: 0.0),
            ],
          ),
        ),
      ),
    );
  }
}
