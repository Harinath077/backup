import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:animate_do/animate_do.dart';
import '../theme/app_theme.dart';
import 'login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<_OnboardingData> _pages = [
    _OnboardingData(
      icon: Icons.shield_rounded,
      iconSecondary: Icons.currency_rupee_rounded,
      heading: 'Real-Time Fraud Shield',
      body:
          'Every UPI payment scanned in under 200ms before it leaves your account.',
    ),
    _OnboardingData(
      icon: Icons.verified_user_rounded,
      iconSecondary: Icons.psychology_rounded,
      heading: 'AI-Powered Risk Engine',
      body:
          'CatBoost ML + Gemini AI analyzes 14 behavioral signals instantly.',
    ),
    _OnboardingData(
      icon: Icons.lock_rounded,
      iconSecondary: Icons.phone_android_rounded,
      heading: 'Zero Compromises',
      body:
          'Bank-grade security. Lightning speed. Complete transparency.',
    ),
  ];

  void _next() {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      _goToLogin();
    }
  }

  void _goToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: _goToLogin,
                child: Text(
                  'Skip',
                  style: AppTheme.dmBody(14, AppTheme.textGrey),
                ),
              ),
            ),
            // PageView
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _pages.length,
                onPageChanged: (i) => setState(() => _currentPage = i),
                itemBuilder: (context, i) =>
                    _buildPage(_pages[i]),
              ),
            ),
            // Bottom section
            Container(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: 3,
                    effect: const ExpandingDotsEffect(
                      activeDotColor: AppTheme.primaryBlue,
                      dotColor: Color(0xFFE2E8F0),
                      dotHeight: 8,
                      dotWidth: 8,
                      expansionFactor: 3,
                      spacing: 6,
                    ),
                  ),
                  const SizedBox(height: 28),
                  // Next / Get Started button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: DecoratedBox(
                      decoration: AppTheme.blueGradientBox(radius: 14),
                      child: ElevatedButton(
                        onPressed: _next,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: Text(
                          _currentPage == 2 ? 'Get Started' : 'Next',
                          style: AppTheme.syneHeading(16, Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage(_OnboardingData data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const Spacer(flex: 1),
          // Illustration area
          FadeInDown(
            duration: const Duration(milliseconds: 600),
            child: Container(
              width: double.infinity,
              height: 280,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF0A2494), Color(0xFF3B5FE8)],
                ),
                borderRadius: BorderRadius.circular(28),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Background decorative circles
                  Positioned(
                    top: 20,
                    right: 30,
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.08),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 30,
                    left: 20,
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.06),
                      ),
                    ),
                  ),
                  // Floating card mockup
                  Container(
                    width: 180,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.15),
                          blurRadius: 30,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(data.icon, size: 48, color: AppTheme.primaryBlue),
                        const SizedBox(height: 12),
                        Icon(data.iconSecondary,
                            size: 28, color: AppTheme.accentBlue),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(flex: 1),
          // Text
          FadeInUp(
            duration: const Duration(milliseconds: 600),
            delay: const Duration(milliseconds: 200),
            child: Text(
              data.heading,
              textAlign: TextAlign.center,
              style: AppTheme.syneHeading(28, AppTheme.textDark),
            ),
          ),
          const SizedBox(height: 12),
          FadeInUp(
            duration: const Duration(milliseconds: 600),
            delay: const Duration(milliseconds: 350),
            child: Text(
              data.body,
              textAlign: TextAlign.center,
              style: AppTheme.dmBody(15, AppTheme.textGrey).copyWith(height: 1.5),
            ),
          ),
          const Spacer(flex: 1),
        ],
      ),
    );
  }
}

class _OnboardingData {
  final IconData icon;
  final IconData iconSecondary;
  final String heading;
  final String body;

  _OnboardingData({
    required this.icon,
    required this.iconSecondary,
    required this.heading,
    required this.body,
  });
}
