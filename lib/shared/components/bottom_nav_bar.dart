import 'package:auto_route/auto_route.dart';
import 'package:cinco_minutos_meditacao/core/routers/app_router.dart';
import 'package:cinco_minutos_meditacao/core/routers/app_router.gr.dart';
import 'package:cinco_minutos_meditacao/shared/Theme/app_colors.dart';
import 'package:cinco_minutos_meditacao/shared/Theme/app_images.dart';
import 'package:cinco_minutos_meditacao/shared/helpers/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  /// Nome da rota atual
  String routeName = '';

  /// Router
  final AppRouter router;

  /// - [routeName] Nome da rota atual
  /// - [router] Router
  /// construtor
  BottomNavBar({required this.routeName, required this.router, super.key});

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
            AppImages.balloonIcon,
            "Meditar",
            shouldShowIdentify(widget.routeName, identifier: Identifiers.home),
            const HomeRoute(),
          ),
          navigatorItem(
            AppImages.meditometerIcon,
            "Meditômetro",
            shouldShowIdentify(widget.routeName,
                identifier: Identifiers.meditometer),
            const MeditometerRoute(),
          ),
          navigatorItem(
            AppImages.favorite,
            "Doar",
            shouldShowIdentify(widget.routeName,
                identifier: Identifiers.donation),
            const DonationRoute(),
          ),
          navigatorItem(
            AppImages.calendarIcon,
            "Calendário",
            shouldShowIdentify(widget.routeName,
                identifier: Identifiers.calendar),
            const CalendarRoute(),
          ),
          navigatorItem(
            AppImages.profile,
            "Perfil",
            shouldShowIdentify(widget.routeName,
                identifier: Identifiers.profile),
            const ProfileRoute(),
          ),
        ],
      ),
    );
  }

  Widget navigatorItem(
      String image, String text, bool isSelected, PageRouteInfo route) {
    return GestureDetector(
      onTap: () {
        shouldShowIdentify(widget.routeName);
        widget.router.goToReplace(route);
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
