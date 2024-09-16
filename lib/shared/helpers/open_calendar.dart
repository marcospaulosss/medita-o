import 'package:url_launcher/url_launcher.dart';

void openCalendar() async {
  await openCalendarAndroid();
}

Future<void> openCalendarAndroid() async {
  final Uri url = Uri.parse('content://com.android.calendar/time/');
  if (!await launchUrl(url)) {
    openWebCalendar();
  }
}

void openWebCalendar() async {
  const String title = 'Meditação';
  const String description = 'Lembre-se de meditar';
  const String location = 'Localização';

  final String url = Uri.encodeFull(
    'https://www.google.com/calendar/render?action=TEMPLATE'
    '&text=$title'
    '&details=$description'
    '&location=$location',
  );

  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  } else {
    print('Não foi possível abrir o Google Calendar.');
  }
}
