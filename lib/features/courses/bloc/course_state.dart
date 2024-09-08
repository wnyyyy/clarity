import 'package:clarity_frontend/core/data/models/course.dart';
import 'package:equatable/equatable.dart';

abstract class CourseState extends Equatable {
  const CourseState();
  @override
  List<Object> get props => [];
}

class CourseListInital extends CourseState {}

class CourseListLoading extends CourseState {}

class CourseListLoaded extends CourseState {
  final Set<Course> courses;

  const CourseListLoaded({required this.courses});

  @override
  List<Object> get props => [courses];
}

class CourseListError extends CourseState {
  final String errorMessage;

  const CourseListError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
