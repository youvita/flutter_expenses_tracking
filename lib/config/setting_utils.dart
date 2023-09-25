import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class Setting{
  static final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  static String? currency = "USD";
  static double? exchangeRate = 4000.0;
  static String? language = "en";
  static bool? isFingerPrint = false;
  static bool? isPin = false;

  Setting.map(Map<String, dynamic> map){
    currency = map['currency'];
    exchangeRate = map['exchangeRate'];
    language = map['language'];
    isFingerPrint = map['isFingerPrint'];
    isPin = map['isPin'];
  }

  Map<String, dynamic> toMap(){
    return {
      'currency': currency,
      'exchangeRate': exchangeRate,
      'language': language,
      'isFingerPrint': isFingerPrint,
      'isPin': isPin
    };
  }

//save to local storage
  Setting.save(){
    _prefs.then((prefs) {
      prefs.setString('setting', jsonEncode(toMap()));
    });
  }

//load from local storage
  Setting.load(){
    _prefs.then((prefs) {
      var setting = prefs.getString('setting');
      if(setting != null){
        log(setting);
        Map<String, dynamic> map = jsonDecode(setting);
        Setting.map(map);
      }else{
        Setting.save();
        Setting.load();
      }
    });
  }

  Setting.changeLanguage(String local){
    language = local;
    Setting.save();
  }

  Setting.updateCurrency(String currency){
    currency = currency;
    Setting.save();
  }

  Setting.updateExchangeRate(double rate){
    exchangeRate = rate;
    Setting.save();
  }

  Setting.updateFingerPrint(bool isFingerPrint){
    isFingerPrint = isFingerPrint;
    Setting.save();
  }

  Setting.updatePin(bool isPin){
    isPin = isPin;
    Setting.save();
  }
}