import 'package:flutter/material.dart';
import 'package:hogastos/components/texts/body_text.dart';
import 'package:hogastos/configurations/authentication.dart';
import 'package:hogastos/configurations/routes.dart';
import 'package:hogastos/helpers/navigator_helper.dart';
import 'package:hogastos/models/user.dart';

import 'menu.dart';

class _LoadingAuth extends StatelessWidget {
  const _LoadingAuth();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

class PageWithMenu extends StatefulWidget {
  final String title;
  final Widget body;
  final List<Widget> actions;
  final Widget? floatingActionButton;

  const PageWithMenu({
    super.key,
    required this.title,
    required this.body,
    required this.actions,
    this.floatingActionButton
  });

  @override
  State<PageWithMenu> createState() => _PageWithMenuState();
}

class _PageWithMenuState extends State<PageWithMenu> {
  User? _user;
  bool _isLoading = true;

  void isLoggedIn() async {
    var authState = AuthState();

    if (authState.isLoggedIn()) {
      setState(() {
        _user = authState.getUser();
        _isLoading = false;
      });
    } else if (await authState.isUserCreated()) {
      await NavigatorHelper.pushNamedAndRemoveUntil(
        context,
        RoutesNames.authLogin,
      );
    } else {
      await NavigatorHelper.pushNamedAndRemoveUntil(
        context,
        RoutesNames.authCreate,
      );
    }
  }

  @override
  void initState() {
    isLoggedIn();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white70,
        title: BodyText(widget.title),
        actions: [
          ...widget.actions,
          SizedBox(width: 10),
          ..._user != null
            ? [ AvatarIcon(user: _user!) ]
            : []
        ],
      ),
      body: _isLoading
        ? _LoadingAuth()
        : widget.body,
      floatingActionButton: widget.floatingActionButton,
    );
  }
}
