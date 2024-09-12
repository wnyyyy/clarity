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
      label: 'pag1',
      icon: Icons.school_outlined,
      selectedIcon: Icons.school
    ),
    AppRouter.home: (
      index: 1,
      label: 'pag2',
      icon: Icons.person_outline,
      selectedIcon: Icons.person
    ),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ColorFiltered(
          colorFilter: const ColorFilter.mode(
            Colors.white,
            BlendMode.srcIn,
          ),
          child: Image.asset(
            'assets/images/logo_azul.png',
            height: 80,
            fit: BoxFit.contain,
          ),
        ),
        centerTitle: true, // Center the logo in the AppBar
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
