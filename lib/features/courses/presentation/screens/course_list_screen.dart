import 'package:clarity_frontend/features/courses/bloc/course_bloc.dart';
import 'package:clarity_frontend/features/courses/bloc/course_event.dart';
import 'package:clarity_frontend/features/courses/bloc/course_state.dart';
import 'package:clarity_frontend/features/courses/presentation/widgets/courses_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseListScreen extends StatelessWidget {
  const CourseListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: BlocBuilder<CourseBloc, CourseState>(
        builder: (context, state) {
          if (state is CourseListInital) {
            context.read<CourseBloc>().add(LoadCourseList());
            return const Center(child: Text("Carregando cursos..."));
          }
          if (state is CourseListLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is CourseListLoaded) {
            return _buildLoadedState(context, state);
          }
          if (state is CourseListError) {
            return const Center(child: Text('Failed to load courses'));
          }
          return const Center();
        },
      ),
    );
  }

  Widget _buildLoadedState(BuildContext context, CourseListLoaded state) {
    final isLightTheme = Theme.of(context).brightness == Brightness.light;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: "Olá ",
            style: Theme.of(context).textTheme.bodyLarge,
            children: [
              TextSpan(
                text: "aluno(a)",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Colors.blueAccent,
                    ),
              ),
              const TextSpan(
                text: ", você já pode acessar os cursos abaixo!",
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          decoration: InputDecoration(
            filled: true,
            fillColor: isLightTheme
                ? const Color(0xFFF0F1F2)
                : const Color(
                    0xFF2C2C2C,
                  ), // Cor da barra de pesquisa ajustada
            hintText: 'Busca Rápida de Cursos',
            contentPadding: const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 15,
            ), // Ajusta o padding para uma melhor apresentação
            suffixIcon: const Icon(Icons.search), // Ícone da lupa no final
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none, // Remove a borda
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          "Lista de Cursos",
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold,
              ),
        ),
        Expanded(child: CoursesList(courses: state.courses.toList())),
      ],
    );
  }
}
