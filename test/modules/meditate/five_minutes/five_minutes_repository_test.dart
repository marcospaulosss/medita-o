import 'package:cinco_minutos_meditacao/core/analytics/manager.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/screens/five_minutes/five_minutes_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'five_minutes_repository_test.mocks.dart';

@GenerateMocks([AnalyticsManager])
void main() {
  group('FiveMinutesRepository', () {
    late FiveMinutesRepository repository;
    late MockAnalyticsManager analytics;

    setUp(() {
      analytics = MockAnalyticsManager();
      repository = FiveMinutesRepository(analytics);
    });

    test('should send open screen event', () {
      when(analytics.sendEvent(any)).thenReturn(null);

      repository.sendOpenScreenEvent();

      verify(analytics.sendEvent(any)).called(1);
    });
  });
}
