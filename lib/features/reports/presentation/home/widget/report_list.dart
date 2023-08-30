import 'package:expenses_tracking/constand/constand.dart';
import 'package:expenses_tracking/features/reports/presentation/home/bloc/report_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportList extends StatelessWidget {
  const ReportList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportListBloc, ReportListState>(
        builder: (context, state) {
      return Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          _HeaderCalendar(),
        ],
      );
    });
  }
}

class _HeaderCalendar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportListBloc, ReportListState>(
        builder: (context, state) {
      return Container(
        width: double.infinity,
        height: 100,
        color: Colors.blue,
        child: Column(
          children: [_YearControl(), _MonthControl()],
        ),
      );
    });
  }
}

class _YearControl extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportListBloc, ReportListState>(
        builder: (context, state) {
      return Row(
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
              icon: const Icon(Icons.arrow_forward_ios, color: MyColors.white)),
        ],
      );
    });
  }
}

class _MonthControl extends StatelessWidget {

  var listOfMonth = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportListBloc, ReportListState>(
        builder: (context, state) {
      return SizedBox(
        height: 50,
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: listOfMonth.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {},
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                  Container(
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    height: 45,
                    child: Center(
                      child: Text(
                        listOfMonth[index],
                        style: MyTextStyles.textStyle1,
                      ),
                    ),
                  ), index==2 ? _monthActiveUnderline() : Container()
                ],),
              );
            }),
      );
    });
  }
}

Widget _monthActiveUnderline() {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.white,
    ),
    width: 20,
    height: 5,
  );
}