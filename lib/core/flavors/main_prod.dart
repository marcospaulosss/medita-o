import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../main.dart' as runner;
import 'flavors.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");

  F.appFlavor = Flavor.prod;
  await runner.main();
}
