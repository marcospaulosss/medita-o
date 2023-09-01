import 'package:auto_route/annotations.dart';
import 'package:cinco_minutos_meditacao/shared/components/background_default.dart';
import 'package:cinco_minutos_meditacao/shared/components/icon_label_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundDefault(
        child: IconLabelButton(
          onTap: () {},
          width: 350,
          height: 55,
          image: SvgPicture.asset(
            'assets/icons/google_logo.svg',
            height: 30,
          ),
          label: const Text(
            'Sua conta Google',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xff2B448C),
              fontFamily: 'Apertura',
            ),
          ),
        ),
      ),
    );
  }
}
