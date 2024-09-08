import 'package:clarity_frontend/core/data/models/course.dart';
import 'package:clarity_frontend/features/courses/bloc/course_bloc.dart';
import 'package:clarity_frontend/features/courses/bloc/course_event.dart';
import 'package:clarity_frontend/features/courses/bloc/course_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseListScreen extends StatelessWidget {
  const CourseListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseBloc, CourseState>(
      builder: (context, state) {
        if (state is CourseListInital) {
          context.read<CourseBloc>().add(LoadCourseList());
          return const Text("estado inicial");
        }
        if (state is CourseListLoading) {
          return const CircularProgressIndicator();
        }
        if (state is CourseListLoaded) {
          return ListView.builder(
            itemCount: state.courses.length,
            itemBuilder: (context, index) {
              final Course course = state.courses.elementAt(index);
              return ListTile(
                title: Text(course.name),
                onTap: () {},
              );
            },
          );
        }
        if (state is CourseListError) {
          return const Text('Failed to load courses');
        }
        return const Center();
      },
    );
  }
}
