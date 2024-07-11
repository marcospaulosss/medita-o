import 'dart:async';

import 'package:cinco_minutos_meditacao/core/analytics/manager.dart';
import 'package:cinco_minutos_meditacao/core/wrappers/secure_storage.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/register/register_repository.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/register_success/register_success_repository.dart';
import 'package:cinco_minutos_meditacao/shared/clients/client_api.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/auth_request.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/register_response.dart';
import 'package:cinco_minutos_meditacao/shared/models/error.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'register_success_repository_test.mocks.dart';

@GenerateMocks([AnalyticsManager])
void main() {
  late RegisterSuccessRepository repository;
  late MockAnalyticsManager mockAnalyticsManager;

  setUp(() {
    mockAnalyticsManager = MockAnalyticsManager();
    repository = RegisterSuccessRepository(mockAnalyticsManager);
  });

  group('RegisterRepository', () {
    test('sendOpenScreenEvent should send registerScreenOpened event', () {
      when(mockAnalyticsManager.sendEvent(any)).thenReturn(null);

      repository.sendOpenScreenEvent();

      verify(mockAnalyticsManager.sendEvent(any)).called(1);
    });
  });
}
