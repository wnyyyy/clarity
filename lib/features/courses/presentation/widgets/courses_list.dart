import 'package:clarity_frontend/core/data/models/course.dart';
import 'package:flutter/material.dart';
import 'package:numerus/numerus.dart';

class CoursesList extends StatelessWidget {
  final List<Course> courses;
  const CoursesList({super.key, required this.courses});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: courses.length,
      itemBuilder: (context, index) {
        final Course course = courses.elementAt(index);
        return Container(
          margin: const EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: index.isEven
                  ? [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.primaryContainer,
                    ]
                  : [
                      Theme.of(context).colorScheme.tertiary,
                      Theme.of(context).colorScheme.tertiaryContainer,
                    ],
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: ListTile(
            minTileHeight: 100,
            title: Text(
              course.name,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: course.progress / 100,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                const SizedBox(height: 4),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            "Nível ${course.level.toRomanNumeralString()}: ${course.progress}%",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
