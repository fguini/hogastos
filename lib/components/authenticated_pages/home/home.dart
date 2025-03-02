import 'package:flutter/material.dart';
import 'package:hogastos/generated/i18n/app_localizations.dart';
import 'package:hogastos/components/authenticated_pages/home/home_layout.dart';
import 'package:hogastos/components/authenticated_pages/page_with_menu.dart';
import 'package:hogastos/components/texts/body_text.dart';
import 'package:hogastos/components/texts/subtitle_text.dart';
import 'package:hogastos/configurations/routes.dart';
import 'package:hogastos/helpers/navigator_helper.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  void _showMenu(
    BuildContext context,
    List<Widget> menuOptions,
  ) => showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: menuOptions,
          ),
        );
      }
  );

  void _goTo(BuildContext context, String routeName)
    => NavigatorHelper.pushNamed(context, routeName);

  void _showReadMenu(BuildContext context) => _showMenu(
      context,
      [
        SubtitleText(AppLocalizations.of(context)!.actionsRead),
        ListTile(
          title: BodyText(AppLocalizations.of(context)!.actionsReadCategories),
          onTap: () => _goTo(context, RoutesNames.categories),
        ),
        ListTile(
          title: BodyText(AppLocalizations.of(context)!.actionsReadYearlyReport),
          onTap: () => _goTo(context, RoutesNames.reportYear),
        ),
      ]
  );

  void _showCreateMenu(BuildContext context) => _showMenu(
    context,
    [
      SubtitleText(AppLocalizations.of(context)!.actionsCreate),
      ListTile(
        title: BodyText(AppLocalizations.of(context)!.actionsCreateNewMovement),
        onTap: () => _goTo(context, RoutesNames.movementsCreate),
      ),
      ListTile(
        title: BodyText(AppLocalizations.of(context)!.actionsCreateNewCategory),
        onTap: () => _goTo(context, RoutesNames.categoriesCreate),
      ),
      Divider(),
      SubtitleText(AppLocalizations.of(context)!.actionsImport),
      ListTile(
        title: BodyText(AppLocalizations.of(context)!.actionsImportFromExcel),
        onTap: () => _goTo(context, RoutesNames.fileImport),
      ),
    ]
  );

  void _showExportMenu(BuildContext context) => _showMenu(
      context,
      [
        SubtitleText(AppLocalizations.of(context)!.actionsExport),
        ListTile(
          title: BodyText(AppLocalizations.of(context)!.actionsExportToExcel),
          onTap: () => _goTo(context, RoutesNames.fileExport),
        ),
      ]
  );

  @override
  Widget build(BuildContext context) {
    return PageWithMenu(
      title: AppLocalizations.of(context)!.appTitle,
      body: HomeLayout(),
      actions: [
        IconButton(
          onPressed: () => _showReadMenu(context),
          icon: Icon(Icons.remove_red_eye),
        ),
        IconButton(
          onPressed: () => _showCreateMenu(context),
          icon: Icon(Icons.add),
        ),
        IconButton(
          onPressed: () => _showExportMenu(context),
          icon: Icon(Icons.file_present_rounded),
        ),
      ],
    );
  }
}
