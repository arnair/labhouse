import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/constants/suggestion_queries.dart';
import '../../../core/theme/app_colors.dart';
import '../../../widgets/app_dialog.dart';

part 'home_controller.g.dart';

@riverpod
class HomeController extends _$HomeController {
  static const _maxQueryLength = 40;
  static const _suggestionCount = 4;
  static final _specialCharsOnlyPattern = RegExp(r'^[\W_]+$');

  @override
  bool build() => false; // false = not submitting, true = submitting

  List<String> getRandomSuggestions() {
    return (List<String>.from(
      kSuggestionQueries,
    )..shuffle(Random())).take(_suggestionCount).toList();
  }

  void handleSearch(
    BuildContext context,
    String input, {
    VoidCallback? onSuccess,
  }) {
    if (state) return;

    final trimmed = input.trim();
    final error = _validateInput(trimmed);

    if (error != null) {
      _showValidationError(context, error);
      return;
    }

    _submitAndNavigate(context, trimmed, onSuccess);
  }

  String? _validateInput(String input) {
    if (input.isEmpty) {
      return 'Please enter a topic to rank.';
    }
    if (input.length > _maxQueryLength) {
      return 'Please keep your query under $_maxQueryLength characters.';
    }
    if (_specialCharsOnlyPattern.hasMatch(input)) {
      return 'Please enter a valid topic. Queries with only special characters are not allowed.';
    }
    return null;
  }

  void _showValidationError(BuildContext context, String message) {
    showAppDialog(
      context,
      title: 'Invalid Input',
      message: message,
      icon: Icons.warning_amber_rounded,
      iconColor: AppColors.error,
      primaryActionText: 'Got it',
    );
  }

  void _submitAndNavigate(
    BuildContext context,
    String query,
    VoidCallback? onSuccess,
  ) {
    state = true;
    onSuccess?.call();

    context.push('/ranking', extra: query).then((_) => resetSubmitting());
  }

  void resetSubmitting() => state = false;
}
