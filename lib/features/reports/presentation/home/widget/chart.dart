import 'package:easy_localization/easy_localization.dart';
import 'package:expenses_tracking/constant/constant.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class ChartReport extends StatefulWidget {
  const ChartReport({super.key});

  @override
  State<ChartReport> createState() => _ChartReportState();
}

class _ChartReportState extends State<ChartReport> {
  int touchedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      AspectRatio(
        aspectRatio: 1.3,
        child: Row(
          children: <Widget>[
            const SizedBox(
              height: 18,
            ),
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: PieChart(
                  PieChartData(
                    pieTouchData: PieTouchData(
                      touchCallback: (FlTouchEvent event, pieTouchResponse) {
                        setState(() {
                          if (!event.isInterestedForInteractions ||
                              pieTouchResponse == null ||
                              pieTouchResponse.touchedSection == null) {
                            touchedIndex = -1;
                            return;
                          }
                          touchedIndex = pieTouchResponse
                              .touchedSection!.touchedSectionIndex;
                        });
                      },
                    ),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    sectionsSpace: 0,
                    centerSpaceRadius: 40,
                    sections: showingSections(),
                  ),
                ),
              ),
            ),

            const SizedBox(
              width: 28,
            ),
          ],
        ),
      ),
      _LabelChart()
    ],);
  }



  List<PieChartSectionData> showingSections() {
    return List.generate(2, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: MyColors.red,
            value: 12,
            title: '30%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: MyColors.white,
              shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: MyColors.green,
            value: 40,
            title: '70%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: MyColors.white,
              shadows: shadows,
            ),
          );
        default:
          throw Error();
      }
    });
  }
}

class _LabelChart extends StatelessWidget {
  const _LabelChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.only(left: 20, right: 20),child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(children: [
          const Text("-\$12", style: MyTextStyles.textStyleBold20Red,),
          const SizedBox(height: 10,),
          Text("Expense".tr(), style: MyTextStyles.textStyleMedium17,),
          const SizedBox(height: 15,),
          SvgPicture.asset("assets/images/Expense-arrow.svg", colorFilter: const ColorFilter.mode(MyColors.red, BlendMode.srcIn),)
        ],),


        Column(children: [
          const Text("+\$40", style: MyTextStyles.textStyleBold20Green,),
          const SizedBox(height: 10,),
          Text("Income".tr(), style: MyTextStyles.textStyleMedium17,),
          const SizedBox(height: 15,),
          SvgPicture.asset("assets/images/Income-arrow.svg", colorFilter: const ColorFilter.mode(MyColors.green, BlendMode.srcIn),)
        ],)

      ],),);
  }
}
