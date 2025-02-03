import 'authentication_strings.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AuthenticationStringsEs extends AuthenticationStrings {
  AuthenticationStringsEs([String locale = 'es']) : super(locale);

  @override
  String get yourGoogleAccount => 'Su cuenta de Google';

  @override
  String get yourFacebookAccount => 'Su cuenta de Facebook';

  @override
  String get exampleEmail => 'ejemplo@email.com';

  @override
  String get email => 'E-mail';

  @override
  String get obscurePassword => '***********';

  @override
  String get password => 'Contraseña';

  @override
  String get rememberPassword => 'Recordar contraseña';

  @override
  String get forgotPassword => 'Olvidé mi contraseña';

  @override
  String get signIn => 'Acceso';

  @override
  String get orEnterUsing => '  O entre usando  ';

  @override
  String get meditateWithoutLogin => 'Meditar sin iniciar sesión';

  @override
  String get createOne => 'crear una ';

  @override
  String get account => 'cuenta';

  @override
  String get invalidEmail => 'E-mail inválido';

  @override
  String get name => 'Nombre';

  @override
  String get confirmPassword => 'Confirmar contraseña';

  @override
  String get createAccount => 'Crear cuenta';

  @override
  String get requiredField => 'Campo obligatorio';

  @override
  String get passwordsDontMatch => 'Las contraseñas no coinciden';

  @override
  String get invalidParameters => 'Parámetros inválidos';

  @override
  String get accountCreatedSuccessfully => 'Cuenta creada con éxito';

  @override
  String get completeYourRegistration => 'Complete su registro';

  @override
  String get haveAccessContent => 'y tenga acceso a todos los contenidos';

  @override
  String get startMeditating => 'Comience a Meditar';
}
