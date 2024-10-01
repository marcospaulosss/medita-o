import 'package:cinco_minutos_meditacao/core/routers/app_router.gr.dart';

enum Identifiers {
  home,
  donation,
  meditometer,
}

bool shouldShowBottomNavigationBar(String routeName) {
  // Defina aqui as rotas que devem exibir o bottomNavigationBar
  const routesWithBottomNavigationBar = [
    HomeRoute.name,
    MeditateInfoRoute.name,
    FiveMinutesRoute.name,
    InYourTimeRoute.name,
    GuidedMeditationRoute.name,
    GuidedMeditationProgramRoute.name,
    DonationRoute.name,
    MeditometerRoute.name,
  ];
  return routesWithBottomNavigationBar.contains(routeName);
}

bool shouldShowIdentify(String routeName, {Identifiers? identifier}) {
  // Defina aqui as rotas que devem exibir o bottomNavigationBar
  var routesWithBottomNavigationBar =
      getRoutesWithBottomNavigationBar(identifier: identifier);
  return routesWithBottomNavigationBar.contains(routeName);
}

getRoutesWithBottomNavigationBar({Identifiers? identifier}) {
  switch (identifier) {
    case Identifiers.home:
      return [
        HomeRoute.name,
        MeditateInfoRoute.name,
        FiveMinutesRoute.name,
        InYourTimeRoute.name,
        GuidedMeditationRoute.name,
        GuidedMeditationProgramRoute.name,
      ];
    case Identifiers.donation:
      return [DonationRoute.name];
    case Identifiers.meditometer:
      return [MeditometerRoute.name];
    default:
      return [
        HomeRoute.name,
        MeditateInfoRoute.name,
        FiveMinutesRoute.name,
        InYourTimeRoute.name,
        GuidedMeditationRoute.name,
        GuidedMeditationProgramRoute.name,
      ];
  }
}
