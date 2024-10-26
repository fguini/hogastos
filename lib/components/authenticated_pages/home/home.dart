import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hogastos/components/authenticated_pages/home/home_layout.dart';
import 'package:hogastos/components/authenticated_pages/page_with_menu.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return PageWithMenu(
      title: AppLocalizations.of(context)!.appTitle,
      body: HomeLayout(),
      actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.remove_red_eye)),
        IconButton(onPressed: () {}, icon: Icon(Icons.create)),
        IconButton(onPressed: () {}, icon: Icon(Icons.file_present_rounded)),
        SizedBox(width: 10),
      ],
    );
  }
}
