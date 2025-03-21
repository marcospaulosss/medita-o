import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:cinco_minutos_meditacao/core/analytics/manager.dart';
import 'package:cinco_minutos_meditacao/core/wrappers/secure_storage.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/analytics/events.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/welcome/welcome_repository.dart';

import 'welcome_repository_test.mocks.dart';

@GenerateMocks([
  AnalyticsManager,
  SecureStorage,
])
void main() {
  late WelcomeRepository repository;
  late MockAnalyticsManager mockAnalyticsManager;
  late MockSecureStorage mockSecureStorage;

  setUp(() {
    mockAnalyticsManager = MockAnalyticsManager();
    mockSecureStorage = MockSecureStorage();
    repository = WelcomeRepository(mockAnalyticsManager, mockSecureStorage);
  });

  group('sendOpenScreenEvent', () {
    test('deve enviar evento de abertura da tela através do AnalyticsManager', () {
      // Act
      repository.sendOpenScreenEvent();

      // Assert
      verify(mockAnalyticsManager.sendEvent(any)).called(1);
    });
  });

  group('isLogged', () {
    test('deve retornar true quando o usuário está logado', () async {
      // Arrange
      when(mockSecureStorage.isLogged).thenAnswer((_) async => true);

      // Act
      final result = await repository.isLogged();

      // Assert
      expect(result, true);
      verify(mockSecureStorage.isLogged).called(1);
    });

    test('deve retornar false quando o usuário não está logado', () async {
      // Arrange
      when(mockSecureStorage.isLogged).thenAnswer((_) async => false);

      // Act
      final result = await repository.isLogged();

      // Assert
      expect(result, false);
      verify(mockSecureStorage.isLogged).called(1);
    });
  });
} 