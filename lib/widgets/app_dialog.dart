import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_text_styles.dart';

/// Show a styled app dialog with optional icon, message, and action buttons
Future<void> showAppDialog(
  BuildContext context, {
  required String title,
  String? message,
  Widget? child,
  IconData? icon,
  Color? iconColor,
  String? primaryActionText,
  VoidCallback? onPrimaryAction,
  String? secondaryActionText,
  VoidCallback? onSecondaryAction,
  bool barrierDismissible = true,
}) {
  assert(
    message != null || child != null,
    'Either message or child must be provided',
  );

  return showDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (context) => _AppDialogContent(
      title: title,
      message: message,
      icon: icon,
      iconColor: iconColor,
      primaryActionText: primaryActionText,
      onPrimaryAction: onPrimaryAction,
      secondaryActionText: secondaryActionText,
      onSecondaryAction: onSecondaryAction,
      child: child,
    ),
  );
}

class _AppDialogContent extends StatelessWidget {
  final String title;
  final String? message;
  final Widget? child;
  final IconData? icon;
  final Color? iconColor;
  final String? primaryActionText;
  final VoidCallback? onPrimaryAction;
  final String? secondaryActionText;
  final VoidCallback? onSecondaryAction;

  const _AppDialogContent({
    required this.title,
    this.message,
    this.child,
    this.icon,
    this.iconColor,
    this.primaryActionText,
    this.onPrimaryAction,
    this.secondaryActionText,
    this.onSecondaryAction,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) _buildIcon(),
            _buildTitle(),
            const SizedBox(height: 8),
            if (message != null) _buildMessage(),
            if (child != null) child!,
            if (_hasActions) _buildActions(context),
          ],
        ),
      ),
    );
  }

  bool get _hasActions =>
      primaryActionText != null || secondaryActionText != null;

  Widget _buildIcon() {
    final color = iconColor ?? AppColors.primary;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color, size: 32),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      title,
      style: AppTextStyles.titleMedium.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _buildMessage() {
    return Text(
      message!,
      textAlign: TextAlign.center,
      style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
    );
  }

  Widget _buildActions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            if (primaryActionText != null)
              _PrimaryButton(
                text: primaryActionText!,
                onPressed: onPrimaryAction ?? () => Navigator.pop(context),
              ),
            if (secondaryActionText != null) ...[
              const SizedBox(height: 8),
              _SecondaryButton(
                text: secondaryActionText!,
                onPressed: onSecondaryAction ?? () => Navigator.pop(context),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const _PrimaryButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.surfaceElevated,
          foregroundColor: AppColors.secondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
        child: Text(text),
      ),
    );
  }
}

class _SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const _SecondaryButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.textSecondary,
        ),
      ),
    );
  }
}
