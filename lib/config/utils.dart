import 'package:easy_localization/easy_localization.dart';

class Utils {

  String getUnicodeCharacter(String codeString) {
    if (codeString == "null" || codeString.isEmpty) return "";
    var codeValue = int.parse(codeString, radix: 16);
    var unicode = String.fromCharCode(codeValue);
    return unicode;
  }

  static DateTime dateTimeFormat(String? stringDateTime) {
    if (stringDateTime?.length != 14) return DateTime.now();
      String format = '${stringDateTime?.substring(0, 8)}T${stringDateTime?.substring(8)}';
    return DateTime.parse(format);
  }

  static String dateFormatYear(DateTime date) {
    return DateFormat('yyyy').format(date);
  }

  static String dateFormatYearMonth(DateTime date) {
    return DateFormat('yyyyMM').format(date);
  }

  static String dateFormat(DateTime date) {
    return DateFormat('dd MMMM yyyy').format(date);
  }

  static String dateFormatMonthYear(DateTime date) {
    return DateFormat('MM/yyyy').format(date);
  }

  static String formatCurrency(String? currency, String? amount) {
    String value = '';
    if(currency == 'USD') {
      value = '\$${NumberFormat('#,###.00', 'en_US').format(double.parse(amount ?? '0'))}';
    } else {
      value = '៛${NumberFormat.decimalPattern().format(double.parse(amount ?? '0'))}';
    }
    return value;
  }

  static String formatSymbol(int value) {
    String strValue;
    if (value == 0) {
      strValue = '';
    } else if (value == 1) {
      strValue = '-';
    } else {
      strValue = '+';
    }
    return strValue;
  }

  static double convertToDouble(String? value) {
    return double.parse(value ?? '');
  }



}
