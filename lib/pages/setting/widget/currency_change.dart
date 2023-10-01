import 'package:expenses_tracking/config/setting_utils.dart';
import 'package:expenses_tracking/constant/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget changeCurrency(BuildContext context, Function callBack){
  return Container(
    height: 180,
    decoration: const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)), color: MyColors.white),
    padding: const EdgeInsets.only(top: 20),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
      const Center(child: Text("Change Currency"),),
      const SizedBox(height: 20,),
      CupertinoListTile(
        title:const Text('Khmer riel'), 
        leading:const Text('៛'),
        trailing: Setting.currency=="KHR" ? const Icon(Icons.check, color: MyColors.blue,) : null,
        onTap: () {
          Setting.updateCurrency('KHR');
          callBack();
          Navigator.pop(context);
        },
        ),
      CupertinoListTile(
        title:const Text('USA Dollar'),
        leading:const Text('\$'),
        trailing: Setting.currency=="USD" ? const Icon(Icons.check, color: MyColors.blue,) : null,
        onTap: () {
          Setting.updateCurrency('USD');
          callBack();
          Navigator.pop(context);
        }),
    ],),
  );
}
