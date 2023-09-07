import 'package:easy_localization/easy_localization.dart';
import 'package:expenses_tracking/config/date_util.dart';

class Utils {

  String getUnicodeCharacter(String codeString) {
    print("code string;:: $codeString");
    if (codeString == "null" || codeString.isEmpty) return "";
    var codeValue = int.parse(codeString, radix: 16);
    var unicode = String.fromCharCode(codeValue);
    return unicode;
  }

  static String dateFormatYYYY(DateTime date){
    return DateFormat("yyyy").format(date);
  }

  static String dateFormat(DateTime date){
    return DateFormat(DateUtil.DAY_MONTH_YEAR).format(date);
  }

}
