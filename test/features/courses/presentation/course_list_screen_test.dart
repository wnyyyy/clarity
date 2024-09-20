import 'package:clarity_frontend/core/data/models/course.dart';
import 'package:clarity_frontend/core/widgets/error_handler.dart';
import 'package:clarity_frontend/features/courses/bloc/course_bloc.dart';
import 'package:clarity_frontend/features/courses/bloc/course_event.dart';
import 'package:clarity_frontend/features/courses/bloc/course_state.dart';
import 'package:clarity_frontend/features/courses/presentation/screens/course_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'course_list_screen_test.mocks.dart';

@GenerateNiceMocks([MockSpec<CourseBloc>()])

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
  // Estamos gerando o mock via build_runner automaticamente, isso é feito na linha '@GenerateNiceMocks([MockSpec<CourseBloc>()])'
  late MockCourseBloc mockCourseBloc;

  // Isso aqui é um método que é chamado antes de cada teste, automaticamente pelo framework. É bom pra inicializar variáveis
  // que precisam estar "limpas" no início de cada teste.
  setUp(() async {
    mockCourseBloc = MockCourseBloc();
  });

  // Isso é só um método para evitar repetição de código.
  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: BlocProvider<CourseBloc>.value(
        value: mockCourseBloc,
        child: const Scaffold(body: CourseListScreen()),
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
    testWidgets(
        'should display loading indicator when state is CourseListLoading',
        (WidgetTester tester) async {
      // Arrange

      // Aqui estamos configurando o mock que definimos acima, utilizando a library mockito. Leia a descrição do when() para entender melhor
      // No nosso caso, estamos dizendo que quando o 'get' do estado do bloc for chamado (mockCourseBloc.state), ele retornará
      // o que definirmos no segundo argumento. No caso, estamos dizendo que o estado é CourseListLoading, pois queremos testar
      // este estado da tela.
      when(mockCourseBloc.state).thenReturn(const CourseListLoading());

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

    testWidgets(
        'should display error handling widget when state is CourseListError',
        (WidgetTester tester) async {
      // Arrange
      when(mockCourseBloc.state).thenReturn(
        const CourseListError(errorMessage: 'mock error message'),
      );

      // Act
      await tester.pumpWidget(createWidgetUnderTest());

      // Assert
      expect(find.byType(ErrorHandler), findsOneWidget);
    });

    testWidgets('should render course list when state is CourseListLoaded',
        (WidgetTester tester) async {
      // Arrange
      final courses = [
        const Course(id: 1, name: 'Test Course 1', level: 1, progress: 50),
        const Course(id: 2, name: 'Test Course 2', level: 2, progress: 75),
      ];
      when(mockCourseBloc.state).thenReturn(
          CourseListLoaded(allCourses: courses, filteredCourses: courses));
      // Como a widget tem um ListView (uma lista que expande inifinitamente), precisamos definir o tamanho da tela
      tester.view.physicalSize = const Size(800, 600);
      tester.view.devicePixelRatio = 1.0;

      // Act
      await tester.pumpWidget(createWidgetUnderTest());

      // Assert
      expect(find.text('Test Course 1'), findsOneWidget);
      expect(find.text('Test Course 2'), findsOneWidget);
      // Para cada curso, deve haver um LinearProgressIndicator, que é a barra de progresso
      expect(find.byType(LinearProgressIndicator), findsNWidgets(2));
    });

    testWidgets(
      'should render search bar',
      (WidgetTester tester) async {},
    );

    testWidgets(
      'should display welcome message with username',
      (WidgetTester tester) async {},
    );

    // Caso o estado seja inicial, a tela deve disparar um evento para carregar a lista de cursos. Isso pode ser feito utilizando verify(), que checa se um método foi chamado, com o número de vezes.
    testWidgets('should trigger LoadCourseList event on initial build',
        (WidgetTester tester) async {
      when(mockCourseBloc.state).thenReturn(const CourseListInital());

      await tester.pumpWidget(createWidgetUnderTest());

      verify(mockCourseBloc.add(LoadCourseList())).called(1);
    });
  });
}
