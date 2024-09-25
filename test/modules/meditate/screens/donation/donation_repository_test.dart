import 'package:cinco_minutos_meditacao/core/analytics/manager.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/screens/donation/donation_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'donation_repository_test.mocks.dart';

@GenerateMocks([AnalyticsManager])
void main() {
  group('DonationRepository', () {
    late DonationRepository repository;
    late MockAnalyticsManager analytics;

    setUp(() {
      analytics = MockAnalyticsManager();
      repository = DonationRepository(analytics);
    });

    test('should send open screen event', () {
      // Arrange
      when(analytics.sendEvent(any)).thenReturn(null);

      // Act
      repository.sendOpenScreenEvent();

      // Assert
      verify(analytics.sendEvent(any)).called(1);
    });
  });
}
