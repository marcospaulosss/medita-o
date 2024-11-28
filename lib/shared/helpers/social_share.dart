import 'dart:io';

import 'package:cinco_minutos_meditacao/shared/models/error.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:social_share/social_share.dart';

/// socialShareImage funcionalidade para compartilhar imagem
Future<CustomError?> socialShareImage(String imageLink, String token) async {
  try {
    final response = await http.get(
      Uri.parse(imageLink),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final directory = await getTemporaryDirectory();
      final filePath = '${directory.path}/image.png';

      final file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);

      await SocialShare.shareOptions(
        'image.png',
        imagePath: filePath,
      );

      return null;
    } else {
      return CustomError().sendErrorToCrashlytics(
          code: ErrorCodes.socialShareError, stackTrace: StackTrace.current);
    }
  } catch (e) {
    return CustomError().sendErrorToCrashlytics(
        code: ErrorCodes.socialShareError, stackTrace: StackTrace.current);
  }
}
