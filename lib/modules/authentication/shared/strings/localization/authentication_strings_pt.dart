import 'authentication_strings.dart';

/// The translations for Portuguese (`pt`).
class AuthenticationStringsPt extends AuthenticationStrings {
  AuthenticationStringsPt([String locale = 'pt']) : super(locale);

  @override
  String get yourGoogleAccount => 'Sua conta Google';

  @override
  String get yourFacebookAccount => 'Sua conta Facebook';

  @override
  String get exampleEmail => 'exemplo@email.com';

  @override
  String get email => 'E-mail';

  @override
  String get obscurePassword => '***********';

  @override
  String get password => 'Senha';

  @override
  String get rememberPassword => 'Lembrar senha';

  @override
  String get forgotPassword => 'Esqueci minha senha';

  @override
  String get signIn => 'Fazer Login';

  @override
  String get orEnterUsing => '  Ou entre usando  ';

  @override
  String get meditateWithoutLogin => 'Meditar sem Login';

  @override
  String get createOne => 'Criar uma ';

  @override
  String get account => 'conta';

  @override
  String get invalidEmail => 'email inválido';

  @override
  String get name => 'Nome';

  @override
  String get confirmPassword => 'Confirmar Senha';

  @override
  String get createAccount => 'Criar Conta';

  @override
  String get requiredField => 'Campo obrigatório';

  @override
  String get passwordsDontMatch => 'Senhas não conferem';

  @override
  String get invalidParameters => 'Parâmetros inválidos';

  @override
  String get accountCreatedSuccessfully => 'Conta criada com Sucesso!';

  @override
  String get completeYourRegistration => 'Complete seu cadastro';

  @override
  String get haveAccessContent => ' e tenha acesso a todos os conteúdos.';

  @override
  String get startMeditating => 'Comece a Meditar';
}
