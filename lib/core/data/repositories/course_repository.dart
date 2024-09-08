import 'dart:io';

import 'package:clarity_frontend/core/data/interfaces/i_course_repository.dart';
import 'package:clarity_frontend/core/data/models/course.dart';

class CourseRepository implements ICourseRepository {
  Uri apiUri;

  CourseRepository({required this.apiUri});

  @override
  Future<Set<Course>> getAllCourses() async {
    sleep(Duration(seconds: 10));
    return new Set<Course>.from([
      Course(id: 1, name: 'aa'),
      Course(
        id: 2,
        name: 'bb',
      ),
    ]);
  }
}
