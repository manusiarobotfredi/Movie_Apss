import 'package:intl/intl.dart';

class DateFormated {
  String dateformated(DateTime datetime) {
    return DateFormat('dd/MM/yyyy hh:mm:ss').format(datetime);
  }
}
