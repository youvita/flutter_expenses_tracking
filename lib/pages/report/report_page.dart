import 'package:expenses_tracking/database/repo/expenses_db.dart';
import 'package:expenses_tracking/pages/report/widget/chart.dart';
import 'package:expenses_tracking/pages/report/widget/summary_report.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  double income=0, expenses=0;

  late BannerAd bannerAd;
  bool isAdLoaded = false;

  /// admob
  initBannerAd() {
    bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: 'ca-app-pub-9089823267744142/9559929319',
        listener: AdManagerBannerAdListener(
            onAdLoaded: (ad) {
              setState(() {
                isAdLoaded = true;
              });
            },
            onAdFailedToLoad: (ad, error) {
              ad.dispose();
            }
        ),
        request: const AdRequest()
    );
    bannerAd.load();
  }

  @override
  void initState() {
    super.initState();
    load(DateTime.now().year.toString());
    initBannerAd();
  }

  load(String year)async{
    income = await ExpensesDb().getTotalExpensesIncome(true, year);
    expenses = await ExpensesDb().getTotalExpensesIncome(false, year);
    
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Align(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SummaryReport(
                        income: income,
                        expenses: expenses,
                        callback: (DateTime date){
                          setState(() {});
                          load(date.year.toString());
                        },),

                      ChartReport(income: income, expenses: expenses,),
                      ColoredBox(
                        color: Colors.white,
                        child: SizedBox(
                          height: bannerAd.size.height.toDouble(),
                          width: double.infinity,
                          child: AdWidget(ad: bannerAd),
                        ),
                      )
                    ],
                  ),
                ),
              )
          ),
    );
  }
}