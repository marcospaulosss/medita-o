import 'package:cinco_minutos_meditacao/core/routers/app_router.dart';
import 'package:cinco_minutos_meditacao/core/routers/app_router.gr.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/register_success/register_success_presenter.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/register_success/register_success_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'register_success_presenter_test.mocks.dart';

@GenerateMocks([RegisterSuccessRepository, AppRouter])
void main() {
  late MockAppRouter mockRouter;
  late MockRegisterSuccessRepository mockRepository;
  late RegisterSuccessPresenter presenter;

  setUp(() {
    mockRouter = MockAppRouter();
    mockRepository = MockRegisterSuccessRepository();
    presenter = RegisterSuccessPresenter(mockRepository, mockRouter);
  });

  group('RegisterSuccessPresenter', () {
    test('goToHome should replace current route with HomeRoute', () {
      presenter.goToHome();

      verify(mockRouter.goToReplace(const HomeRoute())).called(1);
    });

    test('onOpenScreen should send open screen event', () {
      presenter.onOpenScreen();

      verify(mockRepository.sendOpenScreenEvent()).called(1);
    });
  });
}
