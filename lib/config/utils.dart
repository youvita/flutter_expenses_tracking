import 'package:easy_localization/easy_localization.dart';
import 'package:expenses_tracking/config/setting_utils.dart';
import 'package:flutter/material.dart';

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

  static String formatCurrency(String? amount) {
    String value = '';
    if(Setting.currency == 'USD') {
      value = '\$${NumberFormat('#,###.00', 'en_US').format(double.parse(amount ?? '0'))}';
    } else {
      value = '៛${NumberFormat.decimalPattern().format(double.parse(amount ?? '0'))}';
    }
    return value;
  }

  static String formatDecimal(String? currency, String? amount) {
    String value = '';
    if (amount != null && amount.isNotEmpty) {
      if (currency == 'USD' || currency == null) {
        value = NumberFormat('#,###.00', 'en_US').format(
            double.parse(amount));
      } else {
        value =
            NumberFormat.decimalPattern().format(double.parse(amount));
      }
    }
    return value;
  }

  static String exchangeAmount(String? currency, String? amount) {
    String value = '';
      if (Setting.currency == 'USD') {
        if (currency == 'KHR') {
          value = (convertToDouble(amount) / Setting.exchangeRate!).toString();
        } else {
          value = amount ?? '';
        }
      } else  {
        if (currency == 'USD') {
          value = (convertToDouble(amount) * Setting.exchangeRate!).toString();
        } else {
          value = amount ?? '';
        }
      }
    return value;
  }

  static String formatSymbol(int value) {
    String strValue;
    if (value == 1) {
      strValue = '+';
    } else {
      strValue = '-';
    }
    return strValue;
  }

  static double convertToDouble(String? value) {
    return double.parse(value ?? '');
  }

  static String findPrcentage(double value, double income, double expenses) {
    double total = income + expenses;
    if(value==0){
      return '0';
    }
    return ((value / total) * 100).toStringAsFixed(0);
  }

  static String currencyToString(double amount){
    if(Setting.currency=='USD') {
      return '\$${NumberFormat('#,##0.00', 'en_US').format(amount)}';
    }else {
      return '៛${NumberFormat.decimalPattern().format(amount)}';
    }
  }
}
