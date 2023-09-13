import 'package:cinco_minutos_meditacao/shared/Theme/app_colors.dart';
import 'package:flutter/material.dart';

/// Widget que representa o background padrão do app.
class BackgroundDefault extends StatelessWidget {
  /// O widget filho
  final Widget? child;

  /// - [key] : A chave do widget.
  /// - [child] : O widget filho.
  const BackgroundDefault({
    super.key,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.backgroundBlue.withOpacity(0.5),
            AppColors.white,
          ],
          stops: const [0.5, 1],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
      ),
      child: child,
    );
  }
}
