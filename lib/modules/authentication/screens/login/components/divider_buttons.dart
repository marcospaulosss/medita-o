import 'package:cinco_minutos_meditacao/modules/authentication/shared/strings/localization/authentication_strings.dart';
import 'package:cinco_minutos_meditacao/shared/Theme/app_colors.dart';
import 'package:flutter/material.dart';

class DividerButtons extends StatelessWidget {
  const DividerButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 13.93),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildExpandedDividerDefault,
          Text(
            AuthenticationStrings.of(context).orEnterUsing,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: AppColors.frankBlue,
            ),
          ),
          buildExpandedDividerDefault,
        ],
      ),
    );
  }

  Expanded get buildExpandedDividerDefault {
    return const Expanded(
      child: Divider(
        color: AppColors.frankBlue,
        thickness: 0.5,
      ),
    );
  }
}
