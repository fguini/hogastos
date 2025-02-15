import 'package:flutter/material.dart';

typedef OnWillPop = Future<void> Function();

class DialogTransition {
  static open(
    BuildContext context,
    Widget modal,
    {
      bool barrierDismissible = true,
      OnWillPop? onWillPop
    }
  ) {
    if(!context.mounted) return;

    showGeneralDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierLabel: '',
      barrierColor: Colors.black.withValues(alpha: 0.5),
      transitionBuilder: (BuildContext context, animation1, animation2, widget) {
        final curvedValue = Curves.easeInOutBack.transform(animation1.value) - 1.0;

        return Transform(
          transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
          child: Opacity(
            opacity: animation1.value,
            child: PopScope(
              canPop: barrierDismissible,
              onPopInvokedWithResult: (didPop, _) async {
                if(onWillPop != null && didPop) {
                  await onWillPop();
                }
              },
              child: modal
            ),
          ),
        );
      },
      pageBuilder: (context, animation1, animation2) => modal,
    );
  }
}