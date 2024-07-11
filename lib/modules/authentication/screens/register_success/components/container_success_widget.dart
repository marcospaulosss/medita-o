import 'package:cinco_minutos_meditacao/modules/authentication/shared/strings/localization/authentication_strings.dart';
import 'package:cinco_minutos_meditacao/shared/Theme/app_colors.dart';
import 'package:flutter/material.dart';

class ContainerSuccess extends StatelessWidget {
  const ContainerSuccess({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(60),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.blueMana,
              borderRadius: BorderRadius.circular(100),
            ),
            width: 150,
            height: 150,
            child: const Icon(
              Icons.check_rounded,
              color: AppColors.white,
              size: 100,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            AuthenticationStrings.of(context).accountCreatedSuccessfully,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.steelWoolColor,
            ),
          ),
        ],
      ),
    );
  }
}
