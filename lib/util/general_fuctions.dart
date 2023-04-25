import 'package:intl/intl.dart';

int howManyYears(String? date, {String format = 'dd/MM/yyyy'}) {
  if (date == null || date.isEmpty) {
    return 0;
  }

  DateTime currentDate = DateTime.now();
  DateTime birthDate = DateFormat(format).parse(date);
  int age = currentDate.year - birthDate.year;
  int month1 = currentDate.month;
  int month2 = birthDate.month;
  if (month2 > month1) {
    age--;
  } else if (month1 == month2) {
    int day1 = currentDate.day;
    int day2 = birthDate.day;
    if (day2 > day1) {
      age--;
    }
  }

  return age;
}
