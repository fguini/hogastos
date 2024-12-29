import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'base_text.dart';

const double _fontSize = 20;

class SubtitleText extends StatelessWidget {
  final String text;

  const SubtitleText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return BaseText(
      text,
      fontSize: _fontSize,
    );
  }
}

class LoadingSubtitleText extends StatelessWidget {
  final double? width;

  const LoadingSubtitleText({
    super.key,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Bone.text(
      fontSize: _fontSize,
      width: width,
    );
  }
}
