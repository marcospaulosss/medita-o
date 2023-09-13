import 'package:cinco_minutos_meditacao/core/analytics/manager.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/login/login_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_repository_test.mocks.dart';

@GenerateMocks([AnalyticsManager])
void main() {
  late MockAnalyticsManager mockAnalyticsManager;
  late LoginRepository loginRepository;

  setUp(() {
    mockAnalyticsManager = MockAnalyticsManager();
    loginRepository = LoginRepository(mockAnalyticsManager);
  });

  group("LoginRepoository", () {
    test("sendOpenScreenEvent validate send open screen event", () {
      when(mockAnalyticsManager.sendEvent(any)).thenAnswer((_) async => {});

      loginRepository.sendOpenScreenEvent();

      verify(mockAnalyticsManager.sendEvent(any));
    });
  });
}
