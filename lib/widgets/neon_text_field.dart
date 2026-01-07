import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_text_styles.dart';

/// Text field with neon glow effect on focus
class NeonTextField extends StatefulWidget {
  const NeonTextField({
    super.key,
    required this.controller,
    this.focusNode,
    this.hintText,
    this.onSubmitted,
    this.suffixIcon,
  });

  final TextEditingController controller;
  final FocusNode? focusNode;
  final String? hintText;
  final ValueChanged<String>? onSubmitted;
  final Widget? suffixIcon;

  @override
  State<NeonTextField> createState() => _NeonTextFieldState();
}

class _NeonTextFieldState extends State<NeonTextField> {
  bool _isFocused = false;

  static const _borderRadius = 20.0;
  static const _animationDuration = Duration(milliseconds: 200);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: _animationDuration,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(_borderRadius),
        boxShadow: _isFocused ? [_buildGlowShadow()] : [],
      ),
      child: Focus(
        onFocusChange: (focused) => setState(() => _isFocused = focused),
        child: TextField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          style: AppTextStyles.bodyLarge.copyWith(color: AppColors.textPrimary),
          decoration: _buildDecoration(),
          textInputAction: TextInputAction.search,
          onSubmitted: widget.onSubmitted,
        ),
      ),
    );
  }

  BoxShadow _buildGlowShadow() {
    return BoxShadow(
      color: AppColors.primary.withValues(alpha: 0.2),
      blurRadius: 16,
      spreadRadius: 1,
      offset: const Offset(0, 4),
    );
  }

  InputDecoration _buildDecoration() {
    return InputDecoration(
      hintText: widget.hintText,
      hintStyle: AppTextStyles.searchHint,
      filled: true,
      fillColor: AppColors.surface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      suffixIcon: widget.suffixIcon != null
          ? Padding(
              padding: const EdgeInsets.only(right: 8),
              child: widget.suffixIcon,
            )
          : null,
      border: _buildBorder(AppColors.cardBorder),
      enabledBorder: _buildBorder(AppColors.cardBorder),
      focusedBorder: _buildBorder(AppColors.primary, width: 2),
    );
  }

  OutlineInputBorder _buildBorder(Color color, {double width = 1}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(_borderRadius),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}
