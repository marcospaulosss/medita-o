import 'package:cinco_minutos_meditacao/shared/Theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppBackground extends StatelessWidget {
  /// Widget filho
  Widget? child;

  /// - [child] Widget filho
  /// construtor
  AppBackground({
    super.key,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.azureishWhite,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: 510,
              decoration: const BoxDecoration(
                color: AppColors.blueNCS,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
            ),
            SafeArea(child: child ?? Container()),
          ],
        ),
      ),
    );
  }
}
