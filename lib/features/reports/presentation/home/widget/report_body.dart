import 'package:expenses_tracking/features/reports/presentation/home/widget/chart.dart';
import 'package:expenses_tracking/features/reports/presentation/home/widget/summary_report.dart';
import 'package:flutter/material.dart';

class ReportBody extends StatefulWidget {
  const ReportBody({super.key});

  @override
  State<ReportBody> createState() => _ReportBodyState();
}

class _ReportBodyState extends State<ReportBody> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: const Column(
          children: [
            SummaryReport(),
            ChartReport(),
          ],
        ),
      ),
    ));
  }
}
