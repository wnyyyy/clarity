import 'package:clarity_frontend/core/data/interfaces/i_course_repository.dart';
import 'package:clarity_frontend/features/courses/bloc/course_event.dart';
import 'package:clarity_frontend/features/courses/bloc/course_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  final ICourseRepository courseRepository;
  CourseBloc({required this.courseRepository}) : super(CourseListInital()) {
    on<LoadCourseList>(_loadCourseList);
  }

  Future<void> _loadCourseList(
    LoadCourseList event,
    Emitter<CourseState> emit,
  ) async {
    try {
      emit(CourseListLoading());
      final courses = await courseRepository.getAllCourses();
      emit(CourseListLoaded(courses: courses));
    } on Exception catch (e) {
      emit(CourseListError(errorMessage: e.toString()));
    }
  }
}
