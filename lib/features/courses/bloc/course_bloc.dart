import 'package:clarity_frontend/core/data/interfaces/i_course_repository.dart';
import 'package:clarity_frontend/core/data/models/course.dart';
import 'package:clarity_frontend/features/courses/bloc/course_event.dart';
import 'package:clarity_frontend/features/courses/bloc/course_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  final ICourseRepository courseRepository;

  CourseBloc({required this.courseRepository}) : super(CourseListInital()) {
    on<LoadCourseList>(_loadCourseList);
    on<UpdateSearchTerm>(_updateSearchTerm);
  }

  Future<void> _loadCourseList(
    LoadCourseList event,
    Emitter<CourseState> emit,
  ) async {
    try {
      emit(CourseListLoading(searchTerm: state.searchTerm));
      final courses = await courseRepository.getAllCourses();
      final filteredCourses =
          _filterCourses(courses.toList(), state.searchTerm);
      emit(
        CourseListLoaded(
          allCourses: courses.toList(),
          filteredCourses: filteredCourses,
          searchTerm: state.searchTerm,
        ),
      );
    } on Exception catch (e) {
      emit(
        CourseListError(
          errorMessage: e.toString(),
          searchTerm: state.searchTerm,
        ),
      );
    }
  }

  void _updateSearchTerm(
    UpdateSearchTerm event,
    Emitter<CourseState> emit,
  ) {
    final currentState = state;
    if (currentState is CourseListLoaded) {
      final filteredCourses =
          _filterCourses(currentState.allCourses, event.searchTerm);
      emit(
        CourseListLoaded(
          allCourses: currentState.allCourses,
          filteredCourses: filteredCourses,
          searchTerm: event.searchTerm,
        ),
      );
    } else {
      emit(CourseListInital(searchTerm: event.searchTerm));
    }
  }

  List<Course> _filterCourses(List<Course> courses, String searchTerm) {
    if (searchTerm.isEmpty) {
      return courses;
    }
    return courses
        .where(
          (course) =>
              course.name.toLowerCase().contains(searchTerm.toLowerCase()),
        )
        .toList();
  }
}
