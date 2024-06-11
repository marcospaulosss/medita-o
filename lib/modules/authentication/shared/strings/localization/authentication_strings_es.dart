import 'authentication_strings.dart';

/// The translations for Spanish Castilian (`es`).
class AuthenticationStringsEs extends AuthenticationStrings {
  AuthenticationStringsEs([String locale = 'es']) : super(locale);

  @override
  String get yourGoogleAccount => 'Su cuenta de Google';

  @override
  String get yourFacebookAccount => 'Tu cuenta de Facebook';

  @override
  String get exampleEmail => 'ejemplo@correo electrónico.com';

  @override
  String get email => 'Correo electrónico';

  @override
  String get obscurePassword => '***********';

  @override
  String get password => 'Contraseña';

  @override
  String get rememberPassword => 'Recordar contraseña';

  @override
  String get forgotPassword => 'Olvidé mi contraseña';

  @override
  String get signIn => 'Iniciar sesión';

  @override
  String get orEnterUsing => '  O ingresa usando  ';

  @override
  String get meditateWithoutLogin => 'Medita sin iniciar sesión';

  @override
  String get createOne => 'Crear uno';

  @override
  String get account => 'cuenta';
}
