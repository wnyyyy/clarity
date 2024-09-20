import 'package:clarity_frontend/core/data/interfaces/i_course_repository.dart';
import 'package:clarity_frontend/core/data/models/course.dart';

class CourseRepository implements ICourseRepository {
  Uri apiUri;

  CourseRepository({required this.apiUri});

  @override
  Future<List<Course>> getAllCourses() async {
    return <Course>[
      const Course(id: 1, name: 'Português', progress: 47, level: 2),
      const Course(id: 2, name: 'Matemática', progress: 33, level: 1),
      const Course(id: 3, name: 'Química', progress: 28, level: 1),
    ];
  }
}
