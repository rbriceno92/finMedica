import 'package:app/util/string_extensions.dart';
import 'package:intl/intl.dart';

extension DateFormating on String {
  String dateFormat() {
    var date = DateTime.parse(this);
    var formattedDate = DateFormat('d MMM h:mm a');
    formattedDate.dateSymbols.AMPMS = ['am', 'pm'];
    return formattedDate.format(date);
  }

  String dateBirthdayFormat() {
    var date = DateTime.parse(this);
    var formattedDate = DateFormat('dd/MM/yyyy');
    return formattedDate.format(date);
  }

  /// Format the String date to "MMM dd, yyyy - h:mm a"
  String consultsDateFormat() {
    if (isEmpty) return this;
    var date = DateTime.parse(this);
    var formattedDate = DateFormat('MMM dd, yyyy - h:mm a');
    formattedDate.dateSymbols.AMPMS = ['am', 'pm'];

    var dateFormatted = formattedDate
        .format(date)
        .capitalizeOnlyFirstWord()
        .replaceAll('.', '');
    return dateFormatted;
  }

  String dateFormatCalendar() {
    var date = DateTime.parse(this);
    var formattedDate = DateFormat('yyyy-MM-dd');
    return formattedDate.format(date);
  }

  /// Format the String date to "dd 'de' MMMM yyyy"
  String dateFormatLocal() {
    var date = DateTime.parse(this);
    var formattedDate = DateFormat("dd 'de' MMMM yyyy");
    return formattedDate.format(date);
  }

  String getHour() {
    var date = DateTime.parse(this);
    var formattedDate = DateFormat('H:mm');
    return formattedDate.format(date);
  }
}

extension DateFormatingToString on DateTime {
  String dateFormat() {
    var date = this;
    var formattedDate = DateFormat('dd/MM/yyyy');
    return formattedDate.format(date);
  }

  String consultDateFormat() {
    var date = this;
    var formattedDate = DateFormat('MMM dd, yyyy - h:mm a');
    return formattedDate.format(date);
  }

  String scheduleFormat() {
    var date = this;
    var formattedDate = DateFormat('E, dd MMM');
    return formattedDate
        .format(date)
        .replaceAll('.', '')
        .capitalizeOnlyFirstWord();
  }

  String dateFormatCalendar() {
    var date = this;
    var formattedDate = DateFormat('yyyy-MM-dd');
    return formattedDate.format(date);
  }
}

String dateMillisecondsFormatLocal(milliseconds) {
  DateTime date = DateTime.fromMillisecondsSinceEpoch(milliseconds * 1000);
  var format = DateFormat('MMM dd, yyyy - h:mm a');
  var dateString = format.format(date);
  return dateString;
}
