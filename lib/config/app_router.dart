import 'package:clarity_frontend/features/courses/bloc/course_bloc.dart';
import 'package:clarity_frontend/features/courses/presentation/screens/course_list_screen.dart';
import 'package:clarity_frontend/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static const String home = '/';
  static const String courses = '/courses';

  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      ShellRoute(
        builder: (BuildContext context, GoRouterState state, Widget child) {
          return MainScreen(child: child);
        },
        routes: <RouteBase>[
          GoRoute(
            path: home,
            pageBuilder: (BuildContext context, GoRouterState state) {
              return const NoTransitionPage(
                child: Text('Home'),
              );
            },
          ),
          GoRoute(
            path: courses,
            pageBuilder: (BuildContext context, GoRouterState state) {
              return NoTransitionPage(
                child: BlocProvider.value(
                  value: context.read<CourseBloc>(),
                  child: const CourseListScreen(),
                ),
              );
            },
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => const Scaffold(
      body: Center(
        child: Text('Sem rota definida'),
      ),
    ),
  );
}
