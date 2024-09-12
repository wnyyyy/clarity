import 'package:clarity_frontend/config/app_router.dart';
import 'package:clarity_frontend/features/onboarding/screens/course_interest_selection_screen.dart';
import 'package:clarity_frontend/features/onboarding/screens/theme_screen.dart';
import 'package:clarity_frontend/features/onboarding/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingHandler extends StatefulWidget {
  const OnboardingHandler({super.key});

  @override
  _OnboardingHandlerState createState() => _OnboardingHandlerState();
}

class _OnboardingHandlerState extends State<OnboardingHandler> {
  int _currentPage = 0;
  final _heightThreshold = 600.0;

  final List<Widget> _pages = [
    const WelcomeScreen(),
    const CourseInterestSelectionScreen(),
    const ThemeScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildBackground(),
          _buildLogo(),
          _buildCard(context),
        ],
      ),
    );
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      setState(() {
        _currentPage++;
      });
    } else {
      context.go(AppRouter.courses);
    }
  }

  Widget _buildBackground() {
    return ColorFiltered(
      colorFilter: ColorFilter.mode(
        Theme.of(context).colorScheme.primary,
        BlendMode.color,
      ),
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/fundo_estrelas.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Positioned(
      top: 20,
      left: 0,
      right: 0,
      child: Column(
        children: [
          Image.asset(
            'assets/images/clarity.png',
            width: 120,
            height: 120,
            fit: BoxFit.contain,
          ),
          Transform.translate(
            offset: const Offset(0, -60),
            child: ColorFiltered(
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
              child: Image.asset(
                'assets/images/logo_azul.png',
                width: 200,
                height: 200,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final cardHeight = screenHeight > _heightThreshold
        ? screenHeight * 0.65
        : _heightThreshold;
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: cardHeight,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: Container(
                    height: double.infinity,
                    padding: const EdgeInsets.only(
                      top: 32,
                      left: 24,
                      right: 24,
                    ),
                    child: _pages[_currentPage],
                  ),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                ),
              ),
            ),
            Visibility(
              visible: _currentPage == _pages.length - 1,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(bottom: 12),
                child: FilledButton(
                  onPressed: _nextPage,
                  child: const Text(
                    'Vamos começar!',
                  ),
                ),
              ),
            ),
            Visibility(
              visible: _currentPage < _pages.length - 1,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: IconButton.filledTonal(
                  onPressed: _nextPage,
                  iconSize: 36,
                  icon: const Icon(Icons.keyboard_arrow_right),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildPageIndicator(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildPageIndicator() {
    final List<Widget> indicators = [];
    for (int i = 0; i < _pages.length; i++) {
      indicators.add(
        Container(
          width: 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: i == _currentPage
                ? Theme.of(context).colorScheme.secondary
                : Theme.of(context).disabledColor,
          ),
        ),
      );
    }
    return indicators;
  }
}
