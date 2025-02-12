import 'package:auto_route/auto_route.dart';
import 'package:cinco_minutos_meditacao/core/routers/app_router.gr.dart';
import 'package:cinco_minutos_meditacao/shared/Theme/app_colors.dart';
import 'package:cinco_minutos_meditacao/shared/Theme/app_images.dart';
import 'package:cinco_minutos_meditacao/shared/components/background_default.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

@RoutePage()
class SplashScreenView extends StatefulWidget {
  const SplashScreenView({super.key});

  @override
  State<SplashScreenView> createState() => SplashScreenViewState();
}

@visibleForTesting
class SplashScreenViewState extends State<SplashScreenView> {
  DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  var deviceData = <String, dynamic>{};

  @override
  void initState() {
    initPlatformState();

    Future.delayed(const Duration(seconds: 6)).then((value) {
      if (mounted) {
        AutoRouter.of(context).replace(const HomeRoute());
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundDefault(
        child: SafeArea(
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(AppImages.balloon),
                const Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80),
                  child: Column(
                    children: [
                      Text(
                        "Este é um aplicativo criado para desenvolver seu bem-estar e somar minutos para a",
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.black,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "paz mundial",
                        style: TextStyle(
                          fontSize: 25,
                          color: AppColors.black,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Image.asset(AppImages.calendarBalloonBlue),
              ],
            ),
          ),
          // child: SizedBox(
          //   width: double.maxFinite,
          //   height: double.infinity,
          //   child: Image.asset(
          //     'assets/images/splash_screen.png',
          //     fit: BoxFit.fill,
          //   ),
          // ),
        ),
      ),
    );
  }

  Future<void> initPlatformState() async {
    try {
      if (defaultTargetPlatform == TargetPlatform.android) {
        deviceData = readAndroidBuildData(await deviceInfoPlugin.androidInfo);
        initialization();
        return;
      } else {
        Future.delayed(const Duration(seconds: 3)).then((value) {
          FlutterNativeSplash.remove();
          if (mounted) AutoRouter.of(context).replace(const HomeRoute());
        });
      }
    } on PlatformException {
      return;
    }
  }

  Map<String, dynamic> readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'version.release': build.version.release,
    };
  }

  void initialization() async {
    if (deviceData["version.release"] == null ||
        int.parse(deviceData["version.release"]) < 12) {
      if (mounted) {
        AutoRouter.of(context).replace(const HomeRoute());
        FlutterNativeSplash.remove();
      }
      return;
    }

    FlutterNativeSplash.remove();
    return;
  }
}
