import 'package:cinco_minutos_meditacao/core/analytics/manager.dart';
import 'package:cinco_minutos_meditacao/core/di/helpers.dart';
import 'package:cinco_minutos_meditacao/core/routers/app_router.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/screens/donation/donation_presenter.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/screens/donation/donation_repository.dart';

abstract class DonationInjector {
  static void setup() {
    registerFactory<DonationPresenter>(
      () => DonationPresenter(
        resolve<DonationRepository>(),
        resolve<AppRouter>(),
      ),
    );

    registerFactory<DonationRepository>(
      () => DonationRepository(
        resolve<AnalyticsManager>(),
      ),
    );
  }
}
