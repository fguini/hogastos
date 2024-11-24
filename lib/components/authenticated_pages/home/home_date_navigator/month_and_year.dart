import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum Month {
  january,
  february,
  march,
  april,
  may,
  june,
  july,
  august,
  september,
  october,
  november,
  december,
}

class MonthAndYear {
  Month month;
  int year;

  MonthAndYear({
    required this.month,
    required this.year
  });

  factory MonthAndYear.now() {
    var now = DateTime.now();
    var month = now.month;
    var year = now.year;

    return MonthAndYear(month: Month.values[month - 1], year: year);
  }

  int get _monthIndex => Month.values.indexOf(month);

  String locale(BuildContext context) {
    return AppLocalizations.of(context)!.monthAndYear(
      DateTime(year, _monthIndex + 1),
      year
    );
  }

  bool equals(MonthAndYear other) => other.month == month && other.year == year;

  MonthAndYear getPrevious() {
    if(_monthIndex == 0) {
      return MonthAndYear(
        month: Month.december,
        year: year - 1,
      );
    }

    return MonthAndYear(
      month: Month.values[_monthIndex - 1],
      year: year,
    );
  }

  MonthAndYear getNext() {
    if(month == Month.december) {
      return MonthAndYear(
        month: Month.january,
        year: year + 1,
      );
    }

    return MonthAndYear(
      month: Month.values[_monthIndex + 1],
      year: year,
    );
  }
}