import 'package:flutter/material.dart';
import 'package:hogastos/generated/i18n/app_localizations.dart';
import 'package:hogastos/configurations/routes.dart';

import 'configurations/themes.dart';

void main() {
  var routes = Routes();

  runApp(
    AppContainer(
      routes: routes,
    )
  );
}

class AppContainer extends StatelessWidget {
  final Routes routes;

  const AppContainer({
    super.key,
    required this.routes,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hogastos',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: RoutesNames.home,
      onGenerateRoute: Routes().onGenerateRoute,
    );
  }
}
