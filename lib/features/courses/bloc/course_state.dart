import 'package:clarity_frontend/core/data/models/course.dart';
import 'package:equatable/equatable.dart';

abstract class CourseState extends Equatable {
  final String searchTerm;

  const CourseState({this.searchTerm = ''});

  @override
  List<Object> get props => [searchTerm];
}

class CourseListInital extends CourseState {
  const CourseListInital({super.searchTerm});
}

class CourseListLoading extends CourseState {
  const CourseListLoading({super.searchTerm});
}

class CourseListLoaded extends CourseState {
  final List<Course> allCourses;
  final List<Course> filteredCourses;

  const CourseListLoaded({
    required this.allCourses,
    required this.filteredCourses,
    super.searchTerm,
  });

  @override
  List<Object> get props => [allCourses, filteredCourses, searchTerm];
}

class CourseListError extends CourseState {
  final String errorMessage;

  const CourseListError({required this.errorMessage, super.searchTerm});

  @override
  List<Object> get props => [errorMessage, searchTerm];
}
