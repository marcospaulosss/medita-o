import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'meditate_strings_en.dart';
import 'meditate_strings_es.dart';
import 'meditate_strings_pt.dart';

/// Callers can lookup localized strings with an instance of MeditateStrings
/// returned by `MeditateStrings.of(context)`.
///
/// Applications need to include `MeditateStrings.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'localization/meditate_strings.dart';
///
/// return MaterialApp(
///   localizationsDelegates: MeditateStrings.localizationsDelegates,
///   supportedLocales: MeditateStrings.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the MeditateStrings.supportedLocales
/// property.
abstract class MeditateStrings {
  MeditateStrings(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static MeditateStrings of(BuildContext context) {
    return Localizations.of<MeditateStrings>(context, MeditateStrings)!;
  }

  static const LocalizationsDelegate<MeditateStrings> delegate = _MeditateStringsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('pt')
  ];

  /// No description provided for @alreadyAdded.
  ///
  /// In pt, this message translates to:
  /// **'Você já somou '**
  String get alreadyAdded;

  /// No description provided for @minutes.
  ///
  /// In pt, this message translates to:
  /// **'minutos'**
  String get minutes;

  /// No description provided for @worldPeace.
  ///
  /// In pt, this message translates to:
  /// **'pela paz mundial!'**
  String get worldPeace;

  /// No description provided for @methodTitle.
  ///
  /// In pt, this message translates to:
  /// **'Método 3 5 3'**
  String get methodTitle;

  /// No description provided for @methodDescriptionPhrase1.
  ///
  /// In pt, this message translates to:
  /// **'Sente-se com a coluna reta.'**
  String get methodDescriptionPhrase1;

  /// No description provided for @methodDescriptionPhrase2.
  ///
  /// In pt, this message translates to:
  /// **'De olhos abertos faça '**
  String get methodDescriptionPhrase2;

  /// No description provided for @methodDescriptionPhrase3.
  ///
  /// In pt, this message translates to:
  /// **'respirações puxando o ar pelo nariz e soltando pela boca.'**
  String get methodDescriptionPhrase3;

  /// No description provided for @methodDescriptionPhrase4.
  ///
  /// In pt, this message translates to:
  /// **'Aperte o play na tela para iniciar a meditação e feche os olhos. Durante '**
  String get methodDescriptionPhrase4;

  /// No description provided for @methodDescriptionPhrase5.
  ///
  /// In pt, this message translates to:
  /// **'minutos concentre-se na trilha sonora. Ao final, abra os olhos e faça mais '**
  String get methodDescriptionPhrase5;

  /// No description provided for @methodDescriptionPhrase6.
  ///
  /// In pt, this message translates to:
  /// **'respirações profundas.'**
  String get methodDescriptionPhrase6;

  /// No description provided for @threeBreaths.
  ///
  /// In pt, this message translates to:
  /// **'3 '**
  String get threeBreaths;

  /// No description provided for @fiveMinutes.
  ///
  /// In pt, this message translates to:
  /// **'5 '**
  String get fiveMinutes;

  /// No description provided for @learnMeditate.
  ///
  /// In pt, this message translates to:
  /// **'Aprenda a meditar'**
  String get learnMeditate;
}

class _MeditateStringsDelegate extends LocalizationsDelegate<MeditateStrings> {
  const _MeditateStringsDelegate();

  @override
  Future<MeditateStrings> load(Locale locale) {
    return SynchronousFuture<MeditateStrings>(lookupMeditateStrings(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'es', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_MeditateStringsDelegate old) => false;
}

MeditateStrings lookupMeditateStrings(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return MeditateStringsEn();
    case 'es': return MeditateStringsEs();
    case 'pt': return MeditateStringsPt();
  }

  throw FlutterError(
    'MeditateStrings.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
