import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'meditometer_strings_en.dart';
import 'meditometer_strings_es.dart';
import 'meditometer_strings_pt.dart';

/// Callers can lookup localized strings with an instance of MeditometerStrings
/// returned by `MeditometerStrings.of(context)`.
///
/// Applications need to include `MeditometerStrings.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'localization/meditometer_strings.dart';
///
/// return MaterialApp(
///   localizationsDelegates: MeditometerStrings.localizationsDelegates,
///   supportedLocales: MeditometerStrings.supportedLocales,
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
/// be consistent with the languages listed in the MeditometerStrings.supportedLocales
/// property.
abstract class MeditometerStrings {
  MeditometerStrings(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static MeditometerStrings of(BuildContext context) {
    return Localizations.of<MeditometerStrings>(context, MeditometerStrings)!;
  }

  static const LocalizationsDelegate<MeditometerStrings> delegate = _MeditometerStringsDelegate();

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

  /// No description provided for @meditometerTitle.
  ///
  /// In pt, this message translates to:
  /// **'Cada vez que você medita, soma seu tempo pela paz mundial.'**
  String get meditometerTitle;

  /// No description provided for @meditometer.
  ///
  /// In pt, this message translates to:
  /// **'MEDITÔMETRO'**
  String get meditometer;

  /// No description provided for @inRealTime.
  ///
  /// In pt, this message translates to:
  /// **'EM TEMPO REAL'**
  String get inRealTime;

  /// No description provided for @minutesMeditated.
  ///
  /// In pt, this message translates to:
  /// **'MINUTOS MEDITADOS NO MUNDO'**
  String get minutesMeditated;

  /// No description provided for @share.
  ///
  /// In pt, this message translates to:
  /// **'Compartilhar'**
  String get share;

  /// No description provided for @meditometerCardDescription1.
  ///
  /// In pt, this message translates to:
  /// **'Este é o contador mundial de minutos meditados através do aplicativo.'**
  String get meditometerCardDescription1;

  /// No description provided for @meditometerParagraph1.
  ///
  /// In pt, this message translates to:
  /// **'O aplicativo '**
  String get meditometerParagraph1;

  /// No description provided for @meditometerParagraph2.
  ///
  /// In pt, this message translates to:
  /// **'“5 Minutos Eu Medito“ '**
  String get meditometerParagraph2;

  /// No description provided for @meditometerParagraph3.
  ///
  /// In pt, this message translates to:
  /// **'foi lançado pela fundadora da Organização Mundial '**
  String get meditometerParagraph3;

  /// No description provided for @meditometerParagraph4.
  ///
  /// In pt, this message translates to:
  /// **'Mãos Sem Fronteiras'**
  String get meditometerParagraph4;

  /// No description provided for @meditometerParagraph5.
  ///
  /// In pt, this message translates to:
  /// **', La Jardinera, e é utilizado em mais de 80 países.'**
  String get meditometerParagraph5;

  /// No description provided for @meditometerParagraph6.
  ///
  /// In pt, this message translates to:
  /// **'O app tem como propósito compartilhar o método 3-5-3 de meditação de maneira prática, simples e eficaz.'**
  String get meditometerParagraph6;

  /// No description provided for @meditometerParagraph7.
  ///
  /// In pt, this message translates to:
  /// **'Somente 5 minutos ao dia são suficientes para conquistar os benefícios de bem-estar.'**
  String get meditometerParagraph7;

  /// No description provided for @aboutProgram.
  ///
  /// In pt, this message translates to:
  /// **'Saiba mais sobre a causa!'**
  String get aboutProgram;
}

class _MeditometerStringsDelegate extends LocalizationsDelegate<MeditometerStrings> {
  const _MeditometerStringsDelegate();

  @override
  Future<MeditometerStrings> load(Locale locale) {
    return SynchronousFuture<MeditometerStrings>(lookupMeditometerStrings(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'es', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_MeditometerStringsDelegate old) => false;
}

MeditometerStrings lookupMeditometerStrings(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return MeditometerStringsEn();
    case 'es': return MeditometerStringsEs();
    case 'pt': return MeditometerStringsPt();
  }

  throw FlutterError(
    'MeditometerStrings.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
