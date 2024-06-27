import 'authentication_strings.dart';

/// The translations for English (`en`).
class AuthenticationStringsEn extends AuthenticationStrings {
  AuthenticationStringsEn([String locale = 'en']) : super(locale);

  @override
  String get yourGoogleAccount => 'Your Google Account';

  @override
  String get yourFacebookAccount => 'Your Facebook Account';

  @override
  String get exampleEmail => 'example@email.com';

  @override
  String get email => 'Email';

  @override
  String get obscurePassword => '***********';

  @override
  String get password => 'Password';

  @override
  String get rememberPassword => 'Remember password';

  @override
  String get forgotPassword => 'I forgot my password';

  @override
  String get signIn => 'Sign In';

  @override
  String get orEnterUsing => '  Or enter using  ';

  @override
  String get meditateWithoutLogin => 'Meditate without Login';

  @override
  String get createOne => 'Create one';

  @override
  String get account => 'account';

  @override
  String get invalidEmail => 'invalid email';

  @override
  String get name => 'Name';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get createAccount => 'Create Account';

  @override
  String get requiredField => 'Required field';

  @override
  String get passwordsDontMatch => 'Passwords don\'t match';
}
