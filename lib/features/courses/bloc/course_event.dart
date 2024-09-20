import 'package:equatable/equatable.dart';

abstract class CourseEvent extends Equatable {
  const CourseEvent();

  @override
  List<Object> get props => [];
}

class LoadCourseList extends CourseEvent {}

class UpdateSearchTerm extends CourseEvent {
  final String searchTerm;

  const UpdateSearchTerm(this.searchTerm);

  @override
  List<Object> get props => [searchTerm];
}
