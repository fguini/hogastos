import 'package:flutter/material.dart';
import 'package:hogastos/components/texts/body_text.dart';
import 'package:hogastos/components/texts/hint_text.dart';

class RoundedListTile extends StatelessWidget {
  final Color? backgroundColor;
  final Color? textColor;
  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool withCard;

  const RoundedListTile({
    super.key,
    this.backgroundColor,
    this.textColor,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.withCard = true,
  });

  Widget _createListTile(RoundedRectangleBorder shape) {
    return ListTile(
      tileColor: withCard ? null : backgroundColor,
      shape: withCard ? null : shape,
      title: BodyText(title, color: textColor),
      subtitle: subtitle != null ? HintText(subtitle!, color: textColor) : null,
      dense: true,
      leading: leading,
      trailing: trailing,
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    var shape = RoundedRectangleBorder(
      borderRadius: const BorderRadius.all(
        Radius.circular(32),
      ),
    );

    var listTile = _createListTile(shape);

    if(withCard) {
      return Card(
        color: backgroundColor,
        shape: shape,
        child: listTile,
      );
    }

    return listTile;
  }
}
