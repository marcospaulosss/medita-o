import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Login'),
    );
  }
}
