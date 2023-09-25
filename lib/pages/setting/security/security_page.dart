import 'package:expenses_tracking/widgets/iOS_setting_appbar.dart';
import 'package:flutter/cupertino.dart';

class SecurityPage extends StatefulWidget {
  const SecurityPage({super.key});

  @override
  State<SecurityPage> createState() => _SecurityPageState();
}

class _SecurityPageState extends State<SecurityPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const IosSettingAppBar(title: 'Security'),
      child: Container());
  }
}