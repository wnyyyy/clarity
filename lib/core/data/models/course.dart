import 'package:equatable/equatable.dart';

class Course extends Equatable {
  final int id;
  final String name;

  const Course({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}
