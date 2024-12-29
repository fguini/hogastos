import 'package:d_chart/single_bar/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hogastos/components/texts/body_text.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeTotalsBar extends StatelessWidget {
  final String text;
  final Color color;
  final double value;
  final double max;
  final double spaceBetween;
  final bool isLoading;

  const HomeTotalsBar({
    super.key,
    required this.text,
    required this.color,
    required this.value,
    required this.max,
    required this.spaceBetween,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    var barWidth = MediaQuery.sizeOf(context).width - 130;

    return
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          BodyText(text),
          SizedBox(width: spaceBetween),
          Skeletonizer.zone(
            child: isLoading
              ? Bone.text(width: barWidth)
              : Animate().custom(
                duration: 300.milliseconds,
                begin: 0,
                end: value,
                builder: (_, value, __) => SizedBox(
                  height: 15,
                  width: MediaQuery.sizeOf(context).width - 130,
                  child: DChartSingleBar(
                    foregroundColor: color,
                    radius: BorderRadius.circular(10),
                    value: value,
                    max: max,
                  ),
                ),
              ),
          ),
        ],
      );
  }
}
