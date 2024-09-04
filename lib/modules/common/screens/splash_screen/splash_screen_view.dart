import 'package:auto_route/auto_route.dart';
import 'package:cinco_minutos_meditacao/core/routers/app_router.gr.dart';
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

    Future.delayed(const Duration(seconds: 5)).then((value) {
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
      body: SafeArea(
        child: SizedBox(
          width: double.maxFinite,
          height: double.infinity,
          child: Image.asset(
            'assets/images/splash_screen.png',
            fit: BoxFit.fill,
          ),
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
      }

      FlutterNativeSplash.remove();
      if (mounted) AutoRouter.of(context).replace(const HomeRoute());
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
