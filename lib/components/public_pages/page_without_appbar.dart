import 'package:flutter/material.dart';

class PageWithoutAppbar extends StatelessWidget {
  final Widget body;

  const PageWithoutAppbar({
    super.key,
    required this.body
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: body,
        ),
      ),
    );
  }
}
