import 'package:cinco_minutos_meditacao/modules/authentication/shared/strings/localization/authentication_strings.dart';
import 'package:flutter/cupertino.dart';

class Validators {
  static String? required(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return AuthenticationStrings.of(context).requiredField;
    }
    return null;
  }

  static String? email(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return AuthenticationStrings.of(context).requiredField;
    }
    // Expressão regular simples para validar o email
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return AuthenticationStrings.of(context).invalidEmail;
    }
    return null;
  }

  static String? repeatPassword(BuildContext context, String? value, String? password) {
    if (value == null || value.isEmpty) {
      return AuthenticationStrings.of(context).requiredField;
    }
    if (value != password) {
      return AuthenticationStrings.of(context).passwordsDontMatch;
    }
    return null;
  }
}