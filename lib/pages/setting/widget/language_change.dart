import 'package:easy_localization/easy_localization.dart';
import 'package:expenses_tracking/config/setting_utils.dart';
import 'package:expenses_tracking/constant/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget changeLanguage(BuildContext context, Function callBack){
  return Container(
    height: 180,
    decoration: const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)), color: MyColors.white),
    padding: const EdgeInsets.only(top: 20),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
      Center(child: Text('Change Language'.tr()),),
      const SizedBox(height: 20,),
      CupertinoListTile(
        title:const Text('Khmer'), 
        leading:const Text('ក'),
        trailing: Setting.language=="km" ? const Icon(Icons.check, color: MyColors.blue,) : null,
        onTap: () {
          context.setLocale(const Locale('km'));
          Setting.changeLanguage('km');
          callBack();
          Navigator.pop(context);
        },
        ),
      CupertinoListTile(
        title:const Text('English'),
        leading:const Text('A'),
        trailing: Setting.language=="en" ? const Icon(Icons.check, color: MyColors.blue,) : null,
        onTap: () {
          context.setLocale(const Locale('en'));
          Setting.changeLanguage('en');
          callBack();
          Navigator.pop(context);
        }),
    ],),
  );
}
