import 'package:clarity_frontend/features/onboarding/widgets/course_selection_list.dart';
import 'package:flutter/material.dart';

class CourseInterestSelectionScreen extends StatelessWidget {
  const CourseInterestSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Selecione os conteúdos que deseja estudar',
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
              ),
        ),
        const Expanded(
          child: CourseSelectionList(
            courses: {
              'Português': Colors.red,
              'Matemática': Colors.blue,
              'Química': Colors.green,
              'Biologia': Colors.orange,
              'Física': Colors.purple,
            },
          ),
        ),
      ],
    );
  }
}
