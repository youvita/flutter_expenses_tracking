import 'package:easy_localization/easy_localization.dart';
import 'package:expenses_tracking/config/setting_utils.dart';
import 'package:expenses_tracking/constant/constant.dart';
import 'package:expenses_tracking/main.dart';
import 'package:expenses_tracking/pages/setting/widget/currency_change.dart';
import 'package:expenses_tracking/pages/setting/widget/exchange_change.dart';
import 'package:expenses_tracking/pages/setting/widget/language_change.dart';
import 'package:expenses_tracking/pages/setting/security/security_page.dart';
import 'package:expenses_tracking/widgets/iOS_setting_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: MyColors.white,
      navigationBar: IosSettingAppBar(title: 'Setting'.tr()),
      child: Padding(
        padding: const EdgeInsets.only(top: 110),
        child: CupertinoListSection.insetGrouped(
          margin: EdgeInsets.zero,
          children: [
            item(
              title: 'Currency'.tr(), 
              iconPath: 'assets/images/coins-hand.svg', 
              trailing: Setting.currency, onTap: ()=>{
                showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context, 
                  builder:(context) => changeCurrency(context, (){setState(() {});})),
              }
            ),

            item(
              title: 'Language'.tr(), 
              iconPath: 'assets/images/flage.svg', 
              trailing: Setting.language=="km" ? "ខ្មែរ" : "English", 
              onTap: () {
                showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context, 
                  builder:(context) => changeLanguage(context, (){setState(() {});}));
              }
            ),

            item(
              title: 'Exchange Rate'.tr(), 
              iconPath: 'assets/images/coins-swap-02.svg', 
              trailing: '៛ ${Setting.exchangeRate!.toStringAsFixed(0)}',
              onTap: (){
                showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context, 
                  builder:(context) => changeExchangeRate(context, (){setState(() {});}));
              }
            ),

            item(
              title: 'Security'.tr(), 
              iconPath: 'assets/images/lock.svg', 
              onTap: () {
                Fluttertoast.showToast(msg: 'Available for next version'.tr());
                // Navigator.push(context, CupertinoPageRoute(builder: (context) => const SecurityPage()));
              }
            ),

            item(
              title: 'About us'.tr(), 
              iconPath: 'assets/images/info-square.svg', 
              onTap: () {
                Fluttertoast.showToast(msg: 'Available for next version'.tr());
              }
            ),

            item(
              title: 'App Version'.tr(), 
              iconPath: 'assets/images/target-05.svg', 
              trailing: appInfo!.version,
            ),
          ],
        ),
      )
    );
  }

  Widget item({Function? onTap, required String title, String? trailing, required String iconPath}) {
    return CupertinoListTile(
      padding: const EdgeInsets.all(15),
      backgroundColor: MyColors.white,
      leading: SvgPicture.asset(iconPath),
      title: Text(title),
      onTap: onTap==null ? null : (){onTap();},
      additionalInfo: Text(trailing??''),
      trailing: onTap==null ? Container() : const CupertinoListTileChevron(),
    );
  }
}