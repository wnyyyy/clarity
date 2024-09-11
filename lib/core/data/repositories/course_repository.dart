import 'package:clarity_frontend/core/data/interfaces/i_course_repository.dart';
import 'package:clarity_frontend/core/data/models/course.dart';

class CourseRepository implements ICourseRepository {
  Uri apiUri;

  CourseRepository({required this.apiUri});

  @override
  Future<Set<Course>> getAllCourses() async {
    return <Course>{
      const Course(id: 1, name: 'aa'),
      const Course(
        id: 2,
        name: 'bb',
      ),
    };
  }
}
