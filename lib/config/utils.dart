class Utils {

  String getUnicodeCharacter(String codeString) {
    if (codeString == "null") return "";
    var codeValue = int.parse(codeString, radix: 16);
    var unicode = String.fromCharCode(codeValue);
    return unicode;
  }

}