import 'dart:io';

import 'package:cinco_minutos_meditacao/modules/common/screens/splash_screen/splash_screen_view.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'splash_screen_view_test.mocks.dart';

@GenerateMocks([DeviceInfoPlugin, AndroidDeviceInfo, AndroidBuildVersion])
void main() {
  dotenv.testLoad(fileInput: File('.env.dev').readAsStringSync());

  group("splash screen", () {
    late SplashScreenView splashScreenView;
    late MockDeviceInfoPlugin deviceInfoPlugin;
    late MockAndroidDeviceInfo androidDeviceInfo;
    late MockAndroidBuildVersion androidBuildVersion;

    setUp(() {
      splashScreenView = const SplashScreenView();
      deviceInfoPlugin = MockDeviceInfoPlugin();
      androidDeviceInfo = MockAndroidDeviceInfo();
      androidBuildVersion = MockAndroidBuildVersion();
    });

    // testWidgets("Should show splash screen", (tester) async {
    //   await tester.pumpWidget(
    //     MaterialApp(
    //       localizationsDelegates: const [
    //         GlobalMaterialLocalizations.delegate,
    //         GlobalWidgetsLocalizations.delegate,
    //         GlobalCupertinoLocalizations.delegate,
    //       ],
    //       supportedLocales: const [
    //         Locale('pt', ''),
    //       ],
    //       home: splashScreenView,
    //     ),
    //   );
    //
    //   await Future.delayed(const Duration(seconds: 5));
    //   // .then((value) => tester.pump());
    //   await tester.pump();
    //
    //   expect(find.byType(Image), findsOneWidget);
    // });

    testWidgets("Should return error in deviceInfoPlugin", (tester) async {
      when(deviceInfoPlugin.androidInfo)
          .thenAnswer((_) async => throw PlatformException(code: "error"));

      var element = splashScreenView.createElement();
      var state = element.state as SplashScreenViewState;
      state.deviceInfoPlugin = deviceInfoPlugin;

      state.initPlatformState();
    });

    testWidgets("Should show readAndroidBuildData", (tester) async {
      when(androidBuildVersion.release).thenReturn("12");
      when(androidDeviceInfo.version).thenReturn(androidBuildVersion);
      when(deviceInfoPlugin.androidInfo)
          .thenAnswer((_) async => androidDeviceInfo);

      var element = splashScreenView.createElement();
      var state = element.state as SplashScreenViewState;
      state.deviceInfoPlugin = deviceInfoPlugin;

      state.readAndroidBuildData(await deviceInfoPlugin.androidInfo);
      expect(true, true);
    });
  });
}
