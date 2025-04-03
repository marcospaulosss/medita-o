import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:get_it/get_it.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/welcome/welcome_view.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/welcome/welcome_presenter.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/shared/strings/localization/authentication_strings.dart';

import 'welcome_view_test.mocks.dart';

@GenerateMocks([WelcomePresenter])
void main() {
  late MockWelcomePresenter mockPresenter;
  final getIt = GetIt.instance;

  setUp(() {
    mockPresenter = MockWelcomePresenter();
    if (getIt.isRegistered<WelcomePresenter>()) {
      getIt.unregister<WelcomePresenter>();
    }
    getIt.registerFactory<WelcomePresenter>(() => mockPresenter);
  });

  tearDown(() {
    if (getIt.isRegistered<WelcomePresenter>()) {
      getIt.unregister<WelcomePresenter>();
    }
  });

  Widget createTestableWidget() {
    return const MaterialApp(
      localizationsDelegates: [
        ...AuthenticationStrings.localizationsDelegates,
      ],
      supportedLocales: AuthenticationStrings.supportedLocales,
      home: WelcomeView(),
    );
  }

  testWidgets('deve renderizar corretamente todos os elementos principais',
      (WidgetTester tester) async {
    await tester.pumpWidget(createTestableWidget());
    await tester.pumpAndSettle();

    // Verifica se o logo está presente
    expect(find.byType(Image), findsOneWidget);

    // Verifica se o botão de entrar está presente
    expect(find.byType(ElevatedButton), findsOneWidget);

    // Verifica se os textos principais estão presentes
    expect(find.byType(RichText), findsNWidgets(3));
  });

  testWidgets('deve chamar navigateToLogin quando o botão é pressionado',
      (WidgetTester tester) async {
    when(mockPresenter.navigateToLogin()).thenAnswer((_) async {});
    
    await tester.pumpWidget(createTestableWidget());
    await tester.pumpAndSettle();

    // Encontra e pressiona o botão
    final button = find.byType(ElevatedButton);
    await tester.tap(button);
    await tester.pumpAndSettle();

    // Verifica se o método foi chamado
    verify(mockPresenter.navigateToLogin()).called(1);
  });

  testWidgets('deve mostrar loading quando _isLoading é true',
      (WidgetTester tester) async {
    await tester.pumpWidget(createTestableWidget());
    await tester.pumpAndSettle();

    // Inicialmente não deve mostrar o loading
    expect(find.byType(CircularProgressIndicator), findsNothing);

    // TODO: Implementar lógica para ativar loading
    // await tester.pump();
    // expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('deve ter semântica correta para acessibilidade',
      (WidgetTester tester) async {
    await tester.pumpWidget(createTestableWidget());
    await tester.pumpAndSettle();

    // Verifica se o logo tem a label de acessibilidade correta
    expect(
      find.bySemanticsLabel('Logo 5 Minutos Eu Medito'),
      findsOneWidget,
    );
  });
} 