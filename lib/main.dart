import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hogastos/configurations/routes.dart';

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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: RoutesNames.home,
      onGenerateRoute: Routes().onGenerateRoute,
    );
  }
}
