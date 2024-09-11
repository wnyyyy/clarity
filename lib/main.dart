import 'package:clarity_frontend/config/app_router.dart';
import 'package:clarity_frontend/config/themes.dart';
import 'package:clarity_frontend/core/data/interfaces/i_course_repository.dart';
import 'package:clarity_frontend/core/data/repositories/course_repository.dart';
import 'package:clarity_frontend/features/courses/bloc/course_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const ClarityApp());
}

class ClarityApp extends StatelessWidget {
  const ClarityApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ICourseRepository>(
          create: (_) => CourseRepository(apiUri: Uri.parse('uri')),
        ),
        ProxyProvider<ICourseRepository, CourseBloc>(
          create: (context) => CourseBloc(
            courseRepository: context.read<ICourseRepository>(),
          ),
          update: (context, repository, previous) =>
              previous ?? CourseBloc(courseRepository: repository),
        ),
      ],
      builder: (context, child) {
        return MaterialApp.router(
          title: 'Clarity',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          routerConfig: AppRouter.router,
        );
      },
    );
  }
}
