import 'package:clarity_frontend/core/data/models/course.dart';
import 'package:clarity_frontend/features/courses/bloc/course_bloc.dart';
import 'package:clarity_frontend/features/courses/bloc/course_event.dart';
import 'package:clarity_frontend/features/courses/bloc/course_state.dart';
import 'package:clarity_frontend/features/courses/presentation/screens/course_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockCourseBloc extends Mock implements CourseBloc {}

// Nós estamos usando bloc para arquitetura. Isso significa que a tela CourseListScreen vai ter sempre um estado atual dentro
// de alguns estados possíveis. Os estados estão definidos em features/bloc/course_state.dart. Os possíveis estados são:
// CourseListInitial, um estado "vazio" em que a tela é inicializada
// CourseListLoading, indica que a tela está carregando. Por exemplo, fazendo uma requisição para buscar a lista de cursos
// CourseListLoaded, é quando a lista de cursos é carregada com sucesso
// CourseListError, para quando ocorre um erro ao carregar a lista de cursos, por exemplo, falha ao conectar à API
// A ideia então é testar se a tela está se comportando corretamente para cada um desses estados. Então, pra isso deve pensar
// que widgets deveriam aparecer na tela para cada um desses estados. Por exemplo, se o estado é CourseListLoading, deveria
// aparecer um indicador de carregamento, o CircularProgressIndicator. Se o estado é CourseListError, deveria aparecer uma mensagem
// de erro. Se o estado é CourseListLoaded, deveria aparecer a lista de cursos. E assim por diante.

void main() {
  // Isso é um mock para o bloc. Um mock é um objeto que simula o comportamento de um objeto real. No caso, estamos simulando
  // o comportamento do bloc CourseBloc. Isso é útil porque não queremos testar o bloc em si, mas sim a tela que usa o bloc.
  // Também nos permite configurar o estado do bloc para cada teste.
  late MockCourseBloc mockCourseBloc;

  // Isso aqui é um método que é chamado antes de cada teste, automaticamente pelo framework. É bom pra inicializar variáveis
  // que precisam estar "limpas" no início de cada teste.
  setUp(() {
    mockCourseBloc = MockCourseBloc();
  });

  // Isso é só um método para evitar repetição de código.
  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: BlocProvider<CourseBloc>.value(
        value: mockCourseBloc,
        child: const CourseListScreen(),
      ),
    );
  }

  // Primeiro definimos um grupo (ou mais, caso seja conveniente) para organizar os testes. Os testes do mesmo grupo dividem 
  // alguns dos mesmos métodos, tipo o setUp() lá em cima.
  group('CourseListScreen', () {

    // Dentro do grupo, são definidos os testes. em "testWidgets(<descrição>)"
    // a descrição deve estar em inglês e ser escrita "should <ação> when <condição>"  
    // Os testes são escritos em 3 partes: Arrange, Act e Assert.
    // Arrange: Configura o estado inicial do teste. Por exemplo, definir o estado do bloc para CourseListLoading
    // Act: Executa a ação que queremos testar. Por exemplo, chamar o método pumpWidget() para renderizar a tela  
    // Assert: Checa se o resultado da ação é o esperado. Por exemplo, checar se o indicador de carregamento está presente na tela

    // Para testar se a tela renderiza seu estado de "carregamento" corretamente, podemos simplesmente checar se o
    // indicador de carregamento está presente na tela.
    testWidgets('should display loading indicator when state is CourseListLoading',
        (WidgetTester tester) async {

      // Arrange

      // Aqui estamos configurando o mock que definimos acima, utilizando a library mockito. Leia a descrição do when() para entender melhor
      // No nosso caso, estamos dizendo que quando o 'get' do estado do bloc for chamado (mockCourseBloc.state), ele retornará
      // o que definirmos no segundo argumento. No caso, estamos dizendo que o estado é CourseListLoading, pois queremos testar
      // este estado da tela.
      when(mockCourseBloc.state).thenReturn(CourseListLoading());

      // Act

      // Aqui estamos criando a widget que queremos testar usando o método auxiliar que definimos antes e invocando o tester
      // Caso ponha um breakpoint em features/courses/presentation/screens/course_list_screen.dart e execute esse teste em modo debug,
      // verá que a checagem de se o estado da tela é CourseListLoading dará como true, pois definimos isso no mock acima.
      await tester.pumpWidget(createWidgetUnderTest());

      // Assert

      // Aqui estamos checando se o indicador de carregamento está presente na tela. O método find.byType() procura por um widget
      // do tipo passado como argumento. Nesse caso, estamos procurando por um widget do tipo CircularProgressIndicator.
      // Há varios métodos find. Por exemplo, find.byIcon() procura por um widget que contenha um ícone específico.
      // No segundo argumento, estamos dizendo que esperamos encontrar um widget do tipo CircularProgressIndicator.
      // Também há vários deste tipo, poderia ser findsNWidgets(2) para checar se há 2 widgets, etc.

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should display error handling widget when state is CourseListError',
        (WidgetTester tester) async {
      when(mockCourseBloc.state).thenReturn(
          const CourseListError(errorMessage: 'Failed to load courses'));

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('Failed to load courses'), findsOneWidget);
    });

    testWidgets('renders course list when state is CourseListLoaded',
        (WidgetTester tester) async {
      final courses = [
        const Course(id: 1, name: 'Flutter Basics', level: 1, progress: 50),
        const Course(id: 2, name: 'Advanced Dart', level: 2, progress: 75),
      ];
      when(mockCourseBloc.state)
          .thenReturn(CourseListLoaded(courses: courses.toSet()));

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('Flutter Basics'), findsOneWidget);
      expect(find.text('Advanced Dart'), findsOneWidget);
      expect(find.byType(LinearProgressIndicator), findsNWidgets(2));
    });

    testWidgets('renders search bar', (WidgetTester tester) async {
      when(mockCourseBloc.state)
          .thenReturn(const CourseListLoaded(courses: {}));

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);
    });

    testWidgets('displays welcome message with placeholder username',
        (WidgetTester tester) async {
      when(mockCourseBloc.state)
          .thenReturn(const CourseListLoaded(courses: {}));

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('Olá '), findsOneWidget);
      expect(find.text('(usuário)'), findsOneWidget);
      expect(find.text(', você já pode acessar os cursos abaixo!'),
          findsOneWidget);
    });

    testWidgets('triggers LoadCourseList event on initial build',
        (WidgetTester tester) async {
      when(mockCourseBloc.state).thenReturn(CourseListInital());

      await tester.pumpWidget(createWidgetUnderTest());

      verify(mockCourseBloc.add(LoadCourseList())).called(1);
    });

    testWidgets('course list items have correct styling',
        (WidgetTester tester) async {
      final courses = [
        const Course(id: 1, name: 'Flutter Basics', level: 1, progress: 50),
        const Course(id: 2, name: 'Advanced Dart', level: 2, progress: 75),
      ];
      when(mockCourseBloc.state)
          .thenReturn(CourseListLoaded(courses: courses.toSet()));

      await tester.pumpWidget(createWidgetUnderTest());

      final listTiles = find.byType(ListTile);
      expect(listTiles, findsNWidgets(2));

      for (var i = 0; i < 2; i++) {
        final listTile = tester.widget<ListTile>(listTiles.at(i));
        expect(listTile.minVerticalPadding, equals(100));

        final container = tester.widget<Container>(
          find
              .ancestor(
                of: listTiles.at(i),
                matching: find.byType(Container),
              )
              .first,
        );

        expect(container.decoration, isA<BoxDecoration>());
        final decoration = container.decoration! as BoxDecoration;
        expect(decoration.borderRadius, equals(BorderRadius.circular(16)));
        expect(decoration.gradient, isA<LinearGradient>());
      }
    });
  });
}
