import 'package:auto_route/auto_route.dart';
import 'package:cinco_minutos_meditacao/core/routers/app_router.gr.dart';
import 'package:cinco_minutos_meditacao/shared/Theme/app_colors.dart';
import 'package:cinco_minutos_meditacao/shared/helpers/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  /// Nome da rota atual
  String routeName = '';

  /// - [routeName] Nome da rota atual
  /// construtor
  BottomNavBar({required this.routeName, super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(22),
          topRight: Radius.circular(22),
        ),
        color: AppColors.white,
      ),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 26),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          navigatorItem(
            "assets/images/icons/Balão.png",
            "Meditar",
            shouldShowIdentify(widget.routeName),
            const HomeRoute(),
          ),
        ],
      ),
    );
  }

  Widget navigatorItem(
      String image, String text, bool isSelected, PageRouteInfo route) {
    return GestureDetector(
      onTap: () {
        AutoRouter.of(context).replace(route);
      },
      child: Column(
        children: [
          Image.asset(image),
          const SizedBox(height: 11),
          Text(
            text,
            style: const TextStyle(
              color: AppColors.steelWoolColor,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 11),
          if (isSelected)
            Container(
              width: 42,
              height: 8,
              decoration: const BoxDecoration(
                color: Color(0xfffecc00),
              ),
            ),
        ],
      ),
    );
  }
}
