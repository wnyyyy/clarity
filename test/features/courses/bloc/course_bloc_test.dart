import 'package:bloc_test/bloc_test.dart';
import 'package:clarity_frontend/core/data/interfaces/i_course_repository.dart';
import 'package:clarity_frontend/core/data/models/course.dart';
import 'package:clarity_frontend/features/courses/bloc/course_bloc.dart';
import 'package:clarity_frontend/features/courses/bloc/course_event.dart';
import 'package:clarity_frontend/features/courses/bloc/course_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'course_bloc_test.mocks.dart';

@GenerateMocks([ICourseRepository])

// Pra testar o bloc, que é o componente lógico da aplicação, usamos a biblioteca bloc_test, que usa os seguintes parâmetros
// 1. Uma string descrevendo o que o teste faz
// 2. build: uma função que retorna o Bloc a ser testado
// 3. act: uma função que realiza uma ação no Bloc (geralmente adicionar um evento, eg: carregar os cursos, atualizar filtro, etc)
// 4. expect: uma lista de estados que esperamos que o Bloc emita após a ação

void main() {
  late MockICourseRepository mockCourseRepository;
  late CourseBloc courseBloc;

  // Enquanto na tela fazemos um mock para o bloc, aqui fazemos um para o repositório.
  setUp(() {
    mockCourseRepository = MockICourseRepository();
    courseBloc = CourseBloc(courseRepository: mockCourseRepository);
  });

  tearDown(() {
    courseBloc.close();
  });

  group('CourseBloc', () {
    final courses = [
      const Course(id: 1, name: 'Test Course 1', level: 1, progress: 50),
      const Course(id: 2, name: 'Test Course 2', level: 2, progress: 75),
    ];

    test('should have CourseListInitial as initial state', () {
      expect(courseBloc.state, isA<CourseListInital>());
    });

    // No teste do bloc, geralmente testamos seu fluxo.
    // Por exemplo, o fluxo para carregar os cursos é CourseListInitial -> CourseListLoading -> CourseListLoaded
    // Primeiro configuramos o mock do repositório para retornar uma lista de cursos
    // Depois adicionamos o evento LoadCourseList ao bloc, tal como a tela faria caso o bloc esteja no estado inicial
    // Por fim, esperamos que o bloc emita os estados CourseListLoading e CourseListLoaded
    // Dentro de expect, usamos a função isA para verificar se os estados que esperamos (e somente esses estados) são emitidos pelo bloc, na ordem correta
    blocTest<CourseBloc, CourseState>(
      'should emit [CourseListLoading, CourseListLoaded] when LoadCourseList is added successfully',
      build: () {
        when(mockCourseRepository.getAllCourses())
            .thenAnswer((_) async => courses);
        return courseBloc;
      },
      act: (bloc) => bloc.add(LoadCourseList()),
      expect: () => [
        isA<CourseListLoading>()
            .having((state) => state.searchTerm, 'searchTerm', equals('')),
        isA<CourseListLoaded>()
            .having((state) => state.allCourses, 'courses', equals(courses)),
      ],
    );

    blocTest<CourseBloc, CourseState>(
      'should emit [CourseListLoading, CourseListError] when LoadCourseList fails',
      build: () {
        when(mockCourseRepository.getAllCourses())
            .thenThrow(Exception('Mock Exception'));
        return courseBloc;
      },
      act: (bloc) => bloc.add(LoadCourseList()),
      expect: () => [
        isA<CourseListLoading>()
            .having((state) => state.searchTerm, 'searchTerm', equals('')),
        isA<CourseListError>().having(
          (state) => state.errorMessage,
          'errorMessage',
          equals('Exception: Mock Exception'),
        ),
      ],
    );
  });
}
