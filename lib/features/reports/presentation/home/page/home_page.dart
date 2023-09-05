import 'package:easy_localization/easy_localization.dart';
import 'package:expenses_tracking/features/reports/presentation/home/bloc/report_list_bloc.dart';
import 'package:expenses_tracking/features/reports/presentation/home/widget/report_body.dart';
import 'package:expenses_tracking/widgets/default_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../di/injection_container.dart';

class ReportHomePage extends StatelessWidget {
  const ReportHomePage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const ReportHomePage());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 12,
        child: Scaffold(
          appBar: DefaultAppBar(title: 'Report'.tr()),
          body: BlocProvider(
            create: (_) => sl<ReportListBloc>(),
            child: const ReportBody(),
          ),
        ));
  }
}