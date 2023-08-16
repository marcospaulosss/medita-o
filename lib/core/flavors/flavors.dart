import 'package:flutter_dotenv/flutter_dotenv.dart';

enum Flavor {
  dev,
  prod,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.dev:
        return 'Dev';
      case Flavor.prod:
        return '5 Minutos';
      default:
        return 'title';
    }
  }

  static String get description => dotenv.get("FOO");

  static bool get isDev => appFlavor == Flavor.dev;
  static bool get isProd => appFlavor == Flavor.prod;
}
