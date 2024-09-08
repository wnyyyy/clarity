import 'package:clarity_frontend/core/data/models/course.dart';

abstract class ICourseRepository<TCourse> {
  Future<Set<Course>> getAllCourses();
}
