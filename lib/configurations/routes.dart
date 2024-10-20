import 'package:flutter/material.dart';
import 'package:hogastos/components/authenticated_pages/home/home.dart';
import 'package:hogastos/components/public_pages/create_user/create_user_page.dart';
import 'package:hogastos/components/public_pages/user_login/user_login_page.dart';

class RoutesNames {
  static String home = '/';

  static String authCreate = '/auth/create';
  static String authLogin = '/auth/login';

  static String categories = '/categories';
  static String categoriesCreate = '/categories/create';
  static String categoriesEdit = '/categories/edit';

  static String fileExport = '/file/export';
  static String fileImport = '/file/import';

  static String movementsCreate = '/movements/create';
  static String movementsEdit = '/movements/edit';

  static String reportYear = '/report/year';

  static String settings = '/settings';
}

class Routes {
  final Map<String, Widget> _routes = {
    RoutesNames.home: const Home(),
    RoutesNames.authCreate: const CreateUserPage(),
    RoutesNames.authLogin: const UserLoginPage(),
  };

  Route _buildPage(RouteSettings settings, Widget pageWidget) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => pageWidget,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;

        var curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  Route onGenerateRoute(RouteSettings settings) {
    if(!_routes.containsKey(settings.name)) {
      throw Exception('No page builder found for ${settings.name} path');
    }

    var widget = _routes[settings.name]!;
    return _buildPage(settings, widget);
  }
}