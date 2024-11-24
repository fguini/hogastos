import 'package:flutter/material.dart';
import 'package:hogastos/components/authenticated_pages/home/home_totals/home_totals_bar.dart';
import 'package:hogastos/components/texts/subtitle_text.dart';
import 'package:hogastos/components/texts/title_text.dart';

class HomeTotals extends StatelessWidget {
  const HomeTotals({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleText('Totales'), // TODO translate
            SubtitleText('Balance: 213€'), // TODO translate
          ],
        ),
        SizedBox(height: 10),
        HomeTotalsBar(
          text: 'Ingresos', // TODO translate
          color: Theme.of(context).colorScheme.primary,
          spaceBetween: 10,
          max: 100,
          value: 80,
        ),
        HomeTotalsBar(
          text: 'Gastos', // TODO translate
          color: Theme.of(context).colorScheme.error,
          spaceBetween: 22,
          max: 100,
          value: 30,
        ),
      ],
    );
  }
}
