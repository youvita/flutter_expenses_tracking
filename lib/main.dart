import 'package:easy_localization/easy_localization.dart';
import 'package:expenses_tracking/di/injection_container.dart' as di;
import 'package:expenses_tracking/features/reports/presentation/home/page/home_page.dart';
import 'package:flutter/material.dart';

void main() async {
  await di.init();
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();


  runApp(EasyLocalization(
    supportedLocales: const [Locale('km'),Locale('en')],
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
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ReportHomePage(),
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      locale: context.locale,
    );
  }
}
