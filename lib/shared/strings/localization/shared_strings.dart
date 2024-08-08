import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'shared_strings_en.dart';
import 'shared_strings_es.dart';
import 'shared_strings_pt.dart';

/// Callers can lookup localized strings with an instance of SharedStrings
/// returned by `SharedStrings.of(context)`.
///
/// Applications need to include `SharedStrings.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'localization/shared_strings.dart';
///
/// return MaterialApp(
///   localizationsDelegates: SharedStrings.localizationsDelegates,
///   supportedLocales: SharedStrings.supportedLocales,
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
/// be consistent with the languages listed in the SharedStrings.supportedLocales
/// property.
abstract class SharedStrings {
  SharedStrings(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static SharedStrings of(BuildContext context) {
    return Localizations.of<SharedStrings>(context, SharedStrings)!;
  }

  static const LocalizationsDelegate<SharedStrings> delegate = _SharedStringsDelegate();

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

  /// No description provided for @genericErrorRetry.
  ///
  /// In pt, this message translates to:
  /// **'Tentar novamente'**
  String get genericErrorRetry;

  /// No description provided for @genericErrorTitle.
  ///
  /// In pt, this message translates to:
  /// **'Tivemos um problema.'**
  String get genericErrorTitle;

  /// No description provided for @genericErrorSubTitle.
  ///
  /// In pt, this message translates to:
  /// **'Encontramos um problema ao carregar os dados. Por favor, tente novamente.'**
  String get genericErrorSubTitle;

  /// No description provided for @meditometer.
  ///
  /// In pt, this message translates to:
  /// **'Meditômetro'**
  String get meditometer;

  /// No description provided for @realTime.
  ///
  /// In pt, this message translates to:
  /// **'EM TEMPO REAL'**
  String get realTime;

  /// No description provided for @millions.
  ///
  /// In pt, this message translates to:
  /// **'milhões '**
  String get millions;

  /// No description provided for @minutesMeditatedWorld.
  ///
  /// In pt, this message translates to:
  /// **'de Minutos meditados no mundo'**
  String get minutesMeditatedWorld;

  /// No description provided for @countriesReached.
  ///
  /// In pt, this message translates to:
  /// **'PAÍSES ALCANÇADOS'**
  String get countriesReached;

  /// No description provided for @hello.
  ///
  /// In pt, this message translates to:
  /// **'Olá'**
  String get hello;
}

class _SharedStringsDelegate extends LocalizationsDelegate<SharedStrings> {
  const _SharedStringsDelegate();

  @override
  Future<SharedStrings> load(Locale locale) {
    return SynchronousFuture<SharedStrings>(lookupSharedStrings(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'es', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_SharedStringsDelegate old) => false;
}

SharedStrings lookupSharedStrings(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return SharedStringsEn();
    case 'es': return SharedStringsEs();
    case 'pt': return SharedStringsPt();
  }

  throw FlutterError(
    'SharedStrings.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
