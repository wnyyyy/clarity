import 'package:clarity_frontend/config/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainScreen extends StatelessWidget {
  final Widget child;

  const MainScreen({super.key, required this.child});

  static const Map<String,
          ({int index, String label, IconData icon, IconData selectedIcon})>
      _routeConfig = {
    AppRouter.courses: (
      index: 0,
      label: 'Cursos',
      icon: Icons.book_outlined,
      selectedIcon: Icons.book
    ),
    AppRouter.home: (
      index: 1,
      label: 'Home',
      icon: Icons.home_outlined,
      selectedIcon: Icons.home
    ),
    AppRouter.profile: (
      index: 2,
      label: 'Perfil',
      icon: Icons.person_outline,
      selectedIcon: Icons.person
    ),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ColorFiltered(
          colorFilter: ColorFilter.mode(
            Theme.of(context).appBarTheme.foregroundColor ??
                Theme.of(context).colorScheme.onPrimary,
            BlendMode.srcIn,
          ),
          child: Image.asset(
            'assets/images/logo_azul.png',
            height: 80,
            fit: BoxFit.contain,
          ),
        ),
        centerTitle: true,
      ),
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _calculateSelectedIndex(context),
        onDestinationSelected: (int index) => _onItemTapped(index, context),
        destinations: _routeConfig.entries
            .map(
              (entry) => NavigationDestination(
                icon: Icon(entry.value.icon),
                selectedIcon: Icon(entry.value.selectedIcon),
                label: entry.value.label,
              ),
            )
            .toList(),
      ),
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final currentRoute = GoRouterState.of(context).uri.toString();
    return _routeConfig[currentRoute]?.index ?? 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    final destination = _routeConfig.entries.firstWhere(
      (entry) => entry.value.index == index,
      orElse: () => _routeConfig.entries.first,
    );
    GoRouter.of(context).go(destination.key);
  }
}
