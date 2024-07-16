import 'package:auto_route/auto_route.dart';
import 'package:cinco_minutos_meditacao/core/di/helpers.dart';
import 'package:cinco_minutos_meditacao/core/flavors/flavors.dart';
import 'package:cinco_minutos_meditacao/modules/common/screens/home/home_contract.dart';
import 'package:cinco_minutos_meditacao/modules/common/screens/home/home_presenter.dart';
import 'package:cinco_minutos_meditacao/modules/common/shared/strings/localization/common_strings.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HomeView extends StatefulWidget {
  const HomeView({
    super.key,
  });

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Presenter presenter = resolve<HomePresenter>();

  @override
  void initState() {
    presenter.onOpenScreen();

    Future.delayed(const Duration(seconds: 10), () {
      presenter.logOut();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(CommonStrings.of(context).home),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            const Text("Home View"),
            Text(F.title),
            const SizedBox(height: 20),
            Text(F.name),
            const SizedBox(height: 20),
            Text(F.description),
          ],
        ),
      ),
    );
  }
}
