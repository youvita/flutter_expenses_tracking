import 'package:expenses_tracking/constand/constand.dart';
import 'package:expenses_tracking/features/reports/presentation/home/bloc/report_list_bloc.dart';
import 'package:expenses_tracking/features/reports/presentation/home/widget/report_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

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
          appBar: AppBar(
              title: const Text('Report'),
              centerTitle: true,
              actions: [
                IconButton(
                  onPressed: () async{

                  },
                  icon: SvgPicture.asset(
                    'assets/images/ic_calendar.svg',
                    colorFilter:
                        const ColorFilter.mode(MyColors.white, BlendMode.srcIn),
                  ),
                )
              ],
              bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(100.0),
                  child: BlocProvider(
                    create: (_) => sl<ReportListBloc>(),
                    child: _AppBarFooter(),
                  ))),
          body: BlocProvider(
            create: (_) => sl<ReportListBloc>(),
            child: const ReportList(),
          ),
        ));
  }
}

class _AppBarFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return BlocBuilder<ReportListBloc, ReportListState>(
        builder: (context, state) {
      return Column(children: [
        _YearControl(),
        TabBar(
            isScrollable: true,
            unselectedLabelColor: Colors.white.withOpacity(0.3),
            indicator: const UnderlineTabIndicator(
              borderSide: BorderSide(color: Colors.white, width: 2),
              // Indicator height
              insets: EdgeInsets.symmetric(horizontal: 48), // Indicator width
            ),
            tabs: state.getMonthTap())
      ]);
    });
  }
}

class _YearControl extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportListBloc, ReportListState>(
        builder: (context, state) {
      return SizedBox(
          height: 50,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: MyColors.white,
                  )),
              const Text(
                "2023",
                style: MyTextStyles.textStyle1,
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_forward_ios,
                      color: MyColors.white)),
            ],
          ));
    });
  }
}
