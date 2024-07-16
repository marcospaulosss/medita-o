import 'package:cinco_minutos_meditacao/core/analytics/manager.dart';
import 'package:cinco_minutos_meditacao/core/wrappers/secure_storage.dart';
import 'package:cinco_minutos_meditacao/modules/common/screens/home/home_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_repository_test.mocks.dart';

@GenerateMocks([AnalyticsManager, SecureStorage])
void main() {
  group("HomeRepository", () {
    late MockAnalyticsManager analytics;
    late MockSecureStorage secureStorage;
    late HomeRepository repository;

    setUp(() {
      analytics = MockAnalyticsManager();
      secureStorage = MockSecureStorage();
      repository = HomeRepository(analytics, secureStorage);
    });

    test("sendOpenScreenEvent", () {
      // arrange
      when(analytics.sendEvent(any)).thenReturn(null);

      // act
      repository.sendOpenScreenEvent();

      // assert
      verify(analytics.sendEvent(any));
    });
  });
}
