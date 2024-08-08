import 'package:cinco_minutos_meditacao/core/routers/app_router.gr.dart';

bool shouldShowBottomNavigationBar(String routeName) {
  // Defina aqui as rotas que devem exibir o bottomNavigationBar
  const routesWithBottomNavigationBar = [
    HomeRoute.name,
    MeditateInfoRoute.name,
  ];
  return routesWithBottomNavigationBar.contains(routeName);
}

bool shouldShowIdentify(String routeName) {
  // Defina aqui as rotas que devem exibir o bottomNavigationBar
  const routesWithBottomNavigationBar = [
    HomeRoute.name,
    MeditateInfoRoute.name,
  ];
  return routesWithBottomNavigationBar.contains(routeName);
}
