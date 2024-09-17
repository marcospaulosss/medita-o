import 'package:cinco_minutos_meditacao/shared/models/error.dart';
import 'package:url_launcher/url_launcher.dart';

/// Função para abrir o Google Calendar.
void openCalendar() async {
  const String title = 'Meditação';
  const String description = 'Lembre-se de meditar';
  const String location = 'Localização';

  final String url = 'https://www.google.com/calendar/render?action=TEMPLATE'
      '&text=${Uri.encodeComponent(title)}'
      '&details=${Uri.encodeComponent(description)}'
      '&location=${Uri.encodeComponent(location)}';

  try {
    final uri = Uri.parse(url);
    final canLaunchResult = await canLaunchUrl(uri);

    if (canLaunchResult) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      CustomError()
          .sendErrorToCrashlytics(code: ErrorCodes.createNewEventCalendar);
    }
  } catch (e) {
    CustomError()
        .sendErrorToCrashlytics(code: ErrorCodes.createNewEventCalendar);
  }
}
