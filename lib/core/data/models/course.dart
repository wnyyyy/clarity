import 'package:equatable/equatable.dart';

class Course extends Equatable {
  final int id;
  final String name;
  final int progress;
  final int level;

  const Course({
    required this.id,
    required this.name,
    required this.progress,
    required this.level,
  });

  @override
  List<Object?> get props => [id, name, progress, level];
}
