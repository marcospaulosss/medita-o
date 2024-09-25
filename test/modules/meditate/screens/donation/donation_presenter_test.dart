import 'package:cinco_minutos_meditacao/core/routers/app_router.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/screens/donation/donation_contract.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/screens/donation/donation_presenter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'donation_presenter_test.mocks.dart';

@GenerateMocks([Repository, AppRouter, DonationViewContract])
void main() {
  group('DonationPresenter', () {
    late DonationPresenter presenter;
    late MockRepository repository;
    late MockAppRouter router;
    late MockDonationViewContract view;

    setUp(() {
      repository = MockRepository();
      router = MockAppRouter();
      view = MockDonationViewContract();
      presenter = DonationPresenter(repository, router);
      presenter.view = view;
    });

    test('should send open screen event on open screen', () {
      // Arrange
      when(repository.sendOpenScreenEvent()).thenReturn(null);

      // Act
      presenter.onOpenScreen();

      // Assert
      verify(repository.sendOpenScreenEvent()).called(1);
    });

    test('should initialize presenter and send open screen event', () async {
      // Arrange
      when(repository.sendOpenScreenEvent()).thenReturn(null);

      // Act
      await presenter.initPresenter();

      // Assert
      verify(repository.sendOpenScreenEvent()).called(1);
    });
  });
}
