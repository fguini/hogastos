import 'package:flutter/material.dart';
import 'package:hogastos/generated/i18n/app_localizations.dart';
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
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        ),
      ),
      initialRoute: RoutesNames.home,
      onGenerateRoute: Routes().onGenerateRoute,
    );
  }
}
