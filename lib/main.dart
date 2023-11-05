import 'package:easy_localization/easy_localization.dart';
import 'package:expenses_tracking/config/setting_utils.dart';
import 'package:expenses_tracking/constant/constant.dart';
import 'package:expenses_tracking/database/service/database_service.dart';
import 'package:expenses_tracking/widgets/bottombar/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:package_info_plus/package_info_plus.dart';

PackageInfo? appInfo;
void main() async {
  var devices = ['6AF75C3100B45748B0BE4EFDBBA673BC'];
  DatabaseService db = DatabaseService();
  db.initialize();
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();

  /// for testing ads
  // RequestConfiguration requestConfiguration = RequestConfiguration(testDeviceIds: devices);
  // MobileAds.instance.updateRequestConfiguration(requestConfiguration);

  Setting.load();
  await EasyLocalization.ensureInitialized();
  appInfo = await PackageInfo.fromPlatform();
  runApp(EasyLocalization(
    supportedLocales: const [Locale('km'), Locale('en')],
    path: 'assets/i18n',
    fallbackLocale: const Locale('en'),
    child: const MyApp(),
  )
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) 
  {
    context.setLocale(Locale(Setting.language.toString()));
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: MyMaterialColors.blue
      ),
      home: const BottomNavigationBarWidget(),
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
    );
  }
}
