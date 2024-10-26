import 'package:flutter/material.dart';
import 'package:hogastos/components/texts/body_text.dart';
import 'package:hogastos/components/texts/subtitle_text.dart';

class Item {
  final String text;
  final Color color;
  final double money;

  Item(this.text, this.color, this.money);
}

var items = [
  Item('test1', Colors.greenAccent, 20),
  Item('test2', Colors.purple, 10),
  Item('test3', Colors.blueAccent, 4),
  Item('test4', Colors.greenAccent, 49),
  Item('test5', Colors.greenAccent, 16),
  Item('test6', Colors.purple, 20.32),
  Item('test7', Colors.purple, 120),
  Item('test8', Colors.purple, 1),
  Item('test9', Colors.blueAccent, 12),
  Item('test10', Colors.greenAccent, 32),
  Item('test11', Colors.greenAccent, 44),
];

class HomeBankMovements extends StatelessWidget {
  const HomeBankMovements({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SubtitleText('Movimientos'), // TODO translate
            ElevatedButton(
              onPressed: () {},
              child: BodyText('Agrupar por categoría'),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Chip(
              label: BodyText('Ingresos'), // TODO translate
              color: WidgetStateProperty.all(
                Theme.of(context).colorScheme.primary
              ),
            ),
            Chip(
              label: BodyText('Gastos'), // TODO translate
              color: WidgetStateProperty.all(
                  Theme.of(context).colorScheme.error
              ),
            ),
            Chip(
              label: BodyText('No computable'), // TODO translate
              color: WidgetStateProperty.all(
                Theme.of(context).colorScheme.secondary
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        Flexible(
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (_, index) {
              var item = items[index];

              return Card(
                child: ListTile(
                  title: BodyText(item.text),
                  leading: SizedBox(
                    width: 10,
                    height: 10,
                    child: ColoredBox(color: item.color),
                  ),
                  trailing: BodyText(
                    '${item.money} €'
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
