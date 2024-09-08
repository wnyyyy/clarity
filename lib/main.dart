import 'package:clarity_frontend/core/data/interfaces/i_course_repository.dart';
import 'package:clarity_frontend/core/data/repositories/course_repository.dart';
import 'package:clarity_frontend/features/courses/bloc/course_bloc.dart';
import 'package:clarity_frontend/features/courses/presentation/screens/course_list_screen.dart';
import 'package:clarity_frontend/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      ],
      builder: (context, child) {
        return BlocProvider(
          create: (_) => CourseBloc(
            courseRepository: Provider.of<ICourseRepository>(context),
          ),
          child: MaterialApp(
            title: 'Clarity',
            // locale: const Locale('pt', 'BR'),
            // supportedLocales: const [
            //   Locale('pt', 'BR'),
            // ],
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: Scaffold(
                bottomNavigationBar: SizedBox(
                    height: 200,
                    width: 100,
                    child: const ColoredBox(color: Colors.deepPurpleAccent)),
                appBar: AppBar(
                  title: const Text(' '),
                ),
                body: const CourseListScreen()),
          ),
        );
      },
    );
  }
}
