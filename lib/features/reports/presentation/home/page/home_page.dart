import 'package:expenses_tracking/features/reports/presentation/home/bloc/report_list_bloc.dart';
import 'package:expenses_tracking/features/reports/presentation/home/widget/report_list.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report'),
        elevation: 0,
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (_) => sl<ReportListBloc>(),
        child: const ReportList(),
      ),
    );
  }
}
