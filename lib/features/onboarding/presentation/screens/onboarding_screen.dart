import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/services/local_storage/local_storage_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/buttons/primary_button.dart';
import '../../../../core/widgets/more/gradient_background.dart';
import '../../domain/entities/onboarding_page_data.dart';
import '../widgets/onboarding_page_widget.dart';

/// Onboarding screen with 3 pages
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingPageData> _pages = const [
    OnboardingPageData(
      title: AppStrings.onboardingTitle1,
      description: AppStrings.onboardingDesc1,
      illustrationIcon: 'message',
    ),
    OnboardingPageData(
      title: AppStrings.onboardingTitle2,
      description: AppStrings.onboardingDesc2,
      illustrationIcon: 'image',
    ),
    OnboardingPageData(
      title: AppStrings.onboardingTitle3,
      description: AppStrings.onboardingDesc3,
      illustrationIcon: 'person',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding();
    }
  }

  void _skip() {
    _completeOnboarding();
  }

  Future<void> _completeOnboarding() async {
    final localStorage = context.read<LocalStorageService>();
    await localStorage.setOnboardingCompleted(true);
    if (mounted) {
      context.goNamed(RouteNames.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        colors: const [
          Color(0xFFB8E0F0),
          Color(0xFFD4C8F0),
        ],
        child: SafeArea(
          child: Column(
            children: [
              // Skip button
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextButton(
                    onPressed: _skip,
                    child: Text(
                      AppStrings.skip,
                      style: TextStyle(
                        color: AppColors.textSecondaryLight,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),

              // Page view
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: _onPageChanged,
                  itemCount: _pages.length,
                  itemBuilder: (context, index) {
                    return OnboardingPageWidget(
                      data: _pages[index],
                    );
                  },
                ),
              ),

              // Page indicator
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: SmoothPageIndicator(
                  controller: _pageController,
                  count: _pages.length,
                  effect: WormEffect(
                    dotColor: AppColors.grey300,
                    activeDotColor: AppColors.primary,
                    dotHeight: 8,
                    dotWidth: 8,
                    spacing: 8,
                  ),
                ),
              ),

              // Navigation button
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
                child: PrimaryButton(
                  text: _currentPage == _pages.length - 1
                      ? AppStrings.getStarted
                      : AppStrings.next,
                  onPressed: _nextPage,
                ).animate().fadeIn(duration: 300.ms),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
