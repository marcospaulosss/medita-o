import 'dart:convert';
import 'dart:io';

import 'package:cinco_minutos_meditacao/shared/models/error.dart';
import 'package:path_provider/path_provider.dart';
import 'package:social_share/social_share.dart';

/// convertImageAndSaveImage funcionalidade para converter imagem e salvar imagem
Future<(String?, String?, CustomError?)> convertImageAndSaveImage(
    String name, String? image) async {
  try {
    final directory = await getTemporaryDirectory();
    final filePath = '${directory.path}/$name}.png';
    final file = File(filePath);
    final decodedBytes = base64Decode(image!);
    await file.writeAsBytes(decodedBytes);

    return ('$name.png', filePath, null);
  } catch (e) {
    return (
      null,
      null,
      CustomError().sendErrorToCrashlytics(
          code: ErrorCodes.socialShareError, stackTrace: StackTrace.current)
    );
  }
}

/// socialShareImage funcionalidade para compartilhar imagem
Future<CustomError?> socialShareImage(String name, String? image) async {
  // try {
  var send = await SocialShare.shareOptions(
    name,
    imagePath: image,
  );
  if (send != null && send) {
    return null;
  }
  return null;

  //   return CustomError().sendErrorToCrashlytics(
  //       code: ErrorCodes.socialShareError, stackTrace: StackTrace.current);
  // } catch (e) {
  //   return CustomError().sendErrorToCrashlytics(
  //       code: ErrorCodes.socialShareError, stackTrace: StackTrace.current);
  // }
}
