import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'common_strings_de.dart';
import 'common_strings_en.dart';
import 'common_strings_es.dart';
import 'common_strings_fr.dart';
import 'common_strings_it.dart';
import 'common_strings_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of CommonStrings
/// returned by `CommonStrings.of(context)`.
///
/// Applications need to include `CommonStrings.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'localization/common_strings.dart';
///
/// return MaterialApp(
///   localizationsDelegates: CommonStrings.localizationsDelegates,
///   supportedLocales: CommonStrings.supportedLocales,
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
/// be consistent with the languages listed in the CommonStrings.supportedLocales
/// property.
abstract class CommonStrings {
  CommonStrings(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static CommonStrings of(BuildContext context) {
    return Localizations.of<CommonStrings>(context, CommonStrings)!;
  }

  static const LocalizationsDelegate<CommonStrings> delegate = _CommonStringsDelegate();

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
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('it'),
    Locale('pt')
  ];

  /// No description provided for @homeHeaderDescription1.
  ///
  /// In pt, this message translates to:
  /// **'Some seu tempo pela paz mundial agora mesmo!'**
  String get homeHeaderDescription1;

  /// No description provided for @meditate5Minutes.
  ///
  /// In pt, this message translates to:
  /// **'Medite 5 \nMinutos'**
  String get meditate5Minutes;

  /// No description provided for @fiveMinutes.
  ///
  /// In pt, this message translates to:
  /// **'5 min'**
  String get fiveMinutes;

  /// No description provided for @learnMethod.
  ///
  /// In pt, this message translates to:
  /// **'Aprenda o \nmétodo'**
  String get learnMethod;

  /// No description provided for @guidedMeditate.
  ///
  /// In pt, this message translates to:
  /// **'Meditação \nguiada'**
  String get guidedMeditate;

  /// No description provided for @meditateTime.
  ///
  /// In pt, this message translates to:
  /// **'Medite no \nseu tempo'**
  String get meditateTime;

  /// No description provided for @profileHeaderDescription1.
  ///
  /// In pt, this message translates to:
  /// **'Clique aqui e complete o seu perfil!'**
  String get profileHeaderDescription1;

  /// No description provided for @profileUpdateInfo.
  ///
  /// In pt, this message translates to:
  /// **'Atualize seus dados de perfil e acompanhe seus minutos meditados!'**
  String get profileUpdateInfo;

  /// No description provided for @profileFormName.
  ///
  /// In pt, this message translates to:
  /// **'Nome'**
  String get profileFormName;

  /// No description provided for @profileFormLastName.
  ///
  /// In pt, this message translates to:
  /// **'Sobrenome'**
  String get profileFormLastName;

  /// No description provided for @gender.
  ///
  /// In pt, this message translates to:
  /// **'Gênero'**
  String get gender;

  /// No description provided for @whereYouLive.
  ///
  /// In pt, this message translates to:
  /// **'Onde Reside'**
  String get whereYouLive;

  /// No description provided for @privacyPolicy1.
  ///
  /// In pt, this message translates to:
  /// **'Ao salvar os seus dados você concorda com a nossa '**
  String get privacyPolicy1;

  /// No description provided for @privacyPolicy2.
  ///
  /// In pt, this message translates to:
  /// **'Política de Privacidade'**
  String get privacyPolicy2;

  /// No description provided for @privacyPolicy.
  ///
  /// In pt, this message translates to:
  /// **'https://www.eumedito.org/politica-de-privacidade/'**
  String get privacyPolicy;

  /// No description provided for @exitApp.
  ///
  /// In pt, this message translates to:
  /// **'SAIR DO APP'**
  String get exitApp;

  /// No description provided for @dateBirth.
  ///
  /// In pt, this message translates to:
  /// **'Data de Nascimento'**
  String get dateBirth;

  /// No description provided for @datePickerLocation.
  ///
  /// In pt, this message translates to:
  /// **'pt_BR'**
  String get datePickerLocation;

  /// No description provided for @day.
  ///
  /// In pt, this message translates to:
  /// **'Dia'**
  String get day;

  /// No description provided for @month.
  ///
  /// In pt, this message translates to:
  /// **'Mês'**
  String get month;

  /// No description provided for @year.
  ///
  /// In pt, this message translates to:
  /// **'Ano'**
  String get year;

  /// No description provided for @profileLabelButton.
  ///
  /// In pt, this message translates to:
  /// **'Salvar Dados'**
  String get profileLabelButton;
}

class _CommonStringsDelegate extends LocalizationsDelegate<CommonStrings> {
  const _CommonStringsDelegate();

  @override
  Future<CommonStrings> load(Locale locale) {
    return SynchronousFuture<CommonStrings>(lookupCommonStrings(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['de', 'en', 'es', 'fr', 'it', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_CommonStringsDelegate old) => false;
}

CommonStrings lookupCommonStrings(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de': return CommonStringsDe();
    case 'en': return CommonStringsEn();
    case 'es': return CommonStringsEs();
    case 'fr': return CommonStringsFr();
    case 'it': return CommonStringsIt();
    case 'pt': return CommonStringsPt();
  }

  throw FlutterError(
    'CommonStrings.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
