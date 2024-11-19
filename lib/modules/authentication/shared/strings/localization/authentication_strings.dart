import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'authentication_strings_en.dart';
import 'authentication_strings_es.dart';
import 'authentication_strings_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AuthenticationStrings
/// returned by `AuthenticationStrings.of(context)`.
///
/// Applications need to include `AuthenticationStrings.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'localization/authentication_strings.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AuthenticationStrings.localizationsDelegates,
///   supportedLocales: AuthenticationStrings.supportedLocales,
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
/// be consistent with the languages listed in the AuthenticationStrings.supportedLocales
/// property.
abstract class AuthenticationStrings {
  AuthenticationStrings(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AuthenticationStrings of(BuildContext context) {
    return Localizations.of<AuthenticationStrings>(context, AuthenticationStrings)!;
  }

  static const LocalizationsDelegate<AuthenticationStrings> delegate = _AuthenticationStringsDelegate();

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

  /// No description provided for @yourGoogleAccount.
  ///
  /// In pt, this message translates to:
  /// **'Sua conta Google'**
  String get yourGoogleAccount;

  /// No description provided for @yourFacebookAccount.
  ///
  /// In pt, this message translates to:
  /// **'Sua conta Facebook'**
  String get yourFacebookAccount;

  /// No description provided for @exampleEmail.
  ///
  /// In pt, this message translates to:
  /// **'exemplo@email.com'**
  String get exampleEmail;

  /// No description provided for @email.
  ///
  /// In pt, this message translates to:
  /// **'E-mail'**
  String get email;

  /// No description provided for @obscurePassword.
  ///
  /// In pt, this message translates to:
  /// **'***********'**
  String get obscurePassword;

  /// No description provided for @password.
  ///
  /// In pt, this message translates to:
  /// **'Senha'**
  String get password;

  /// No description provided for @rememberPassword.
  ///
  /// In pt, this message translates to:
  /// **'Lembrar senha'**
  String get rememberPassword;

  /// No description provided for @forgotPassword.
  ///
  /// In pt, this message translates to:
  /// **'Esqueci minha senha'**
  String get forgotPassword;

  /// No description provided for @signIn.
  ///
  /// In pt, this message translates to:
  /// **'Fazer Login'**
  String get signIn;

  /// No description provided for @orEnterUsing.
  ///
  /// In pt, this message translates to:
  /// **'  Ou entre usando  '**
  String get orEnterUsing;

  /// No description provided for @meditateWithoutLogin.
  ///
  /// In pt, this message translates to:
  /// **'Meditar sem Login'**
  String get meditateWithoutLogin;

  /// No description provided for @createOne.
  ///
  /// In pt, this message translates to:
  /// **'Criar uma '**
  String get createOne;

  /// No description provided for @account.
  ///
  /// In pt, this message translates to:
  /// **'conta'**
  String get account;

  /// No description provided for @invalidEmail.
  ///
  /// In pt, this message translates to:
  /// **'email inválido'**
  String get invalidEmail;

  /// No description provided for @name.
  ///
  /// In pt, this message translates to:
  /// **'Nome'**
  String get name;

  /// No description provided for @confirmPassword.
  ///
  /// In pt, this message translates to:
  /// **'Confirmar Senha'**
  String get confirmPassword;

  /// No description provided for @createAccount.
  ///
  /// In pt, this message translates to:
  /// **'Criar Conta'**
  String get createAccount;

  /// No description provided for @requiredField.
  ///
  /// In pt, this message translates to:
  /// **'Campo obrigatório'**
  String get requiredField;

  /// No description provided for @passwordsDontMatch.
  ///
  /// In pt, this message translates to:
  /// **'Senhas não conferem'**
  String get passwordsDontMatch;

  /// No description provided for @invalidParameters.
  ///
  /// In pt, this message translates to:
  /// **'Parâmetros inválidos'**
  String get invalidParameters;

  /// No description provided for @accountCreatedSuccessfully.
  ///
  /// In pt, this message translates to:
  /// **'Conta criada com Sucesso!'**
  String get accountCreatedSuccessfully;

  /// No description provided for @completeYourRegistration.
  ///
  /// In pt, this message translates to:
  /// **'Complete seu cadastro'**
  String get completeYourRegistration;

  /// No description provided for @haveAccessContent.
  ///
  /// In pt, this message translates to:
  /// **' e tenha acesso a todos os conteúdos.'**
  String get haveAccessContent;

  /// No description provided for @startMeditating.
  ///
  /// In pt, this message translates to:
  /// **'Comece a Meditar'**
  String get startMeditating;
}

class _AuthenticationStringsDelegate extends LocalizationsDelegate<AuthenticationStrings> {
  const _AuthenticationStringsDelegate();

  @override
  Future<AuthenticationStrings> load(Locale locale) {
    return SynchronousFuture<AuthenticationStrings>(lookupAuthenticationStrings(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'es', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AuthenticationStringsDelegate old) => false;
}

AuthenticationStrings lookupAuthenticationStrings(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AuthenticationStringsEn();
    case 'es': return AuthenticationStringsEs();
    case 'pt': return AuthenticationStringsPt();
  }

  throw FlutterError(
    'AuthenticationStrings.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
