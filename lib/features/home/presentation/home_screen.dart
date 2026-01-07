import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../widgets/glassy_chip.dart';
import '../../../../widgets/gradient_background.dart';
import '../../../../widgets/neon_text_field.dart';
import 'home_controller.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final _queryController = TextEditingController();
  late final List<String> _suggestions;

  HomeController get _controller => ref.read(homeControllerProvider.notifier);

  @override
  void initState() {
    super.initState();
    _suggestions = _controller.getRandomSuggestions();
  }

  @override
  void dispose() {
    _queryController.dispose();
    super.dispose();
  }

  void _submitQuery() {
    _controller.handleSearch(
      context,
      _queryController.text,
      onSuccess: _queryController.clear,
    );
  }

  void _selectSuggestion(String suggestion) {
    _queryController.text = suggestion;
    _submitQuery();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(homeControllerProvider);

    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          gradient: AppColors.primaryGradient,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withValues(alpha: 0.3),
                              blurRadius: 20,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.emoji_events_rounded,
                          size: 40,
                          color: AppColors.background,
                        ),
                      ),
                      const SizedBox(height: 24),
                      ShaderMask(
                        shaderCallback: (bounds) =>
                            AppColors.primaryGradient.createShader(bounds),
                        child: Text(
                          'RankQuest',
                          style: AppTextStyles.displayLarge.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Ask anything, get ranked results',
                        style: AppTextStyles.bodyLarge.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 48),

                  // Search Field
                  NeonTextField(
                    controller: _queryController,
                    hintText: 'What would you like to rank?',
                    onSubmitted: (_) => _submitQuery(),
                    suffixIcon: IconButton(
                      icon: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          gradient: AppColors.primaryGradient,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.arrow_forward_rounded,
                          color: AppColors.background,
                          size: 20,
                        ),
                      ),
                      onPressed: _submitQuery,
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Suggestions Section
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.auto_awesome_rounded,
                            size: 16,
                            color: AppColors.textSecondary,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Try these',
                            style: AppTextStyles.labelMedium.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 8,
                        runSpacing: 8,
                        children: _suggestions
                            .map(
                              (s) => GlassyChip(
                                label: s,
                                onTap: () => _selectSuggestion(s),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
