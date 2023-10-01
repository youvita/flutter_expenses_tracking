import 'dart:developer';

import 'package:expenses_tracking/config/setting_utils.dart';
import 'package:expenses_tracking/constant/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
double _text = 0;
Widget changeExchangeRate(BuildContext context, Function callBack){
  _text==0 ? _text = Setting.exchangeRate! : _text = _text;
  return Container(
    height: 190,
    margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
    decoration: const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)), color: MyColors.white),
    padding: const EdgeInsets.only(top: 20),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
      const Center(child: Text("Change Exchange Rate"),),
      const SizedBox(height: 30,),
      Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SizedBox(
          height: 50,
          child: TextFormField(
            decoration: const InputDecoration(
              fillColor: MyColors.greyBackground,
              filled: true,
              border: OutlineInputBorder(borderSide: BorderSide.none)
            ),
            keyboardType: TextInputType.number,
            initialValue: _text.toStringAsFixed(2),
            onChanged: (value){
              _text = value.isEmpty ? 0 : double.parse(value);
            },
            autofocus: true,
          ),
        ),
      ),
      const SizedBox(height: 10,),
      CupertinoButton(child: const Text('Change'), onPressed: (){
        Setting.updateExchangeRate(_text);
        callBack();
        Navigator.pop(context);
      })
    ],),
  );
}
