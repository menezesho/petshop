import 'package:intl/intl.dart';

class Functions {
  static String? validateDate(value) {
    try {
      DateTime parsedDate = DateFormat('dd/MM/yyyy').parse(value);
      return DateFormat('yyyy-MM-dd').format(parsedDate);
    } catch (e) {
      return null;
    }
  }
}
