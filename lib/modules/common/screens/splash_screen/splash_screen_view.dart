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
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  var deviceData = <String, dynamic>{};

  @override
  void initState() {
    initPlatformState();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.maxFinite,
        height: double.infinity,
        child: Image.asset(
          'assets/images/splash_screen.png',
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Future<void> initPlatformState() async {
    try {
      if (defaultTargetPlatform == TargetPlatform.android) {
        deviceData = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
      }
    } on PlatformException {
      if (kDebugMode) {
        print("Failed to get platform version");
      }
    }

    initialization();
  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'tags': build.tags,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
      'systemFeatures': build.systemFeatures,
      'displaySizeInches':
          ((build.displayMetrics.sizeInches * 10).roundToDouble() / 10),
      'displayWidthPixels': build.displayMetrics.widthPx,
      'displayWidthInches': build.displayMetrics.widthInches,
      'displayHeightPixels': build.displayMetrics.heightPx,
      'displayHeightInches': build.displayMetrics.heightInches,
      'displayXDpi': build.displayMetrics.xDpi,
      'displayYDpi': build.displayMetrics.yDpi,
      'serialNumber': build.serialNumber,
    };
  }

  void initialization() async {
    if (deviceData["version.release"] == null ||
        int.parse(deviceData["version.release"]) < 12) {
      // ignore: use_build_context_synchronously
      AutoRouter.of(context).replace(const HomeRoute());
      FlutterNativeSplash.remove();
      return;
    }

    FlutterNativeSplash.remove();
    await Future.delayed(const Duration(seconds: 5));
    // ignore: use_build_context_synchronously
    AutoRouter.of(context).replace(const HomeRoute());
  }
}
