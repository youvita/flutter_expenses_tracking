import 'dart:io';

import 'package:expenses_tracking/config/utils.dart';
import 'package:expenses_tracking/constant/constant.dart';
import 'package:expenses_tracking/database/models/year_header.dart';
import 'package:expenses_tracking/database/repo/expenses_db.dart';
import 'package:expenses_tracking/pages/home/list_item.dart';
import 'package:expenses_tracking/widgets/toggle_swich.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:sticky_headers/sticky_headers.dart';
import '../../database/models/expenses.dart';
import '../create/create_page.dart';
import '../create/status_switch.dart';

class ListFormWidget extends StatefulWidget {

  const  ListFormWidget({super.key, required this.callBack});

  final Function callBack;

  @override
  State<StatefulWidget> createState() => _ListFormState();

}

class _ListFormState extends State<ListFormWidget> {

  late BannerAd bannerAd;
  bool isAdLoaded = false;

  var lastWeek = "";
  var lastHeaderYear = "";
  var lastHeaderMonth = "";
  var totalAmountYear = 0.0;
  var totalAmountMonth = 0.0;
  int toggleIndex = 0;
  int expandCounter = 0;
  bool defaultExpand = true;
  bool isSameWeek = false;
  ScrollController scrollController = ScrollController();

  List<Expenses> listItem = List.empty();
  List<String> listHeaderWeek = List.empty(growable: true);
  List<String> listHeaderYear = List.empty(growable: true);
  List<DateTime> listHeaderMonth = List.empty(growable: true);
  List<double> listTotalEachYear = List.empty(growable: true);
  List<double> listTotalEachMonth = List.empty(growable: true);
  List<YearHeader> listVisibleHeader = List.empty(growable: true);
  List<int> listCounter = List.empty(growable: true);

  /// admob
  initBannerAd() {
    bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: Platform.isAndroid ? 'ca-app-pub-9089823267744142/9527892306' : 'ca-app-pub-9089823267744142/8292801878',
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

  /// load from db
  loadExpense(String status) async {
    listItem = await ExpensesDb().query(status);

    /// set for update UI while back from setting
    setState(() {
      /// remove line if list no data
      if (listItem.isEmpty) {
        listVisibleHeader.clear();
        listCounter.clear();
      }
    });
  }

  /// load to from list
  loadForm() {
    if (listItem.isNotEmpty) {
      for (var i = 0; i < listItem.length; i++) {
        DateTime dateTime = Utils.dateTimeFormat("${listItem
            .elementAt(i)
            .createDate}");
        String header = Utils.dateFormatYear(dateTime);
        String headerMonth = Utils.dateFormatYearMonth(dateTime);
        if (lastHeaderYear != header) {
          listHeaderYear.add(header);
          lastHeaderYear = header;

          listVisibleHeader.add(YearHeader(header, true)); // false: hide header blue line, true: show header blue line
        }

        if (lastHeaderMonth != headerMonth) {
          listHeaderMonth.add(dateTime);
          lastHeaderMonth = headerMonth;
        }
      }

      /// loop to sum total amount each year
      for (var i = 0; i < listHeaderYear.length; i++) {
        for (var j = i; j < listItem.length; j++) {
          if (listHeaderYear.elementAt(i) ==
              Utils.dateFormatYear(Utils.dateTimeFormat("${listItem
                  .elementAt(j)
                  .createDate}"))) {
            totalAmountYear =
                totalAmountYear + double.parse(Utils.exchangeAmount(listItem
                    .elementAt(j)
                    .currencyCode, listItem
                    .elementAt(j)
                    .amount));
          }
        }
        listTotalEachYear.add(totalAmountYear);
        totalAmountYear = 0.0;
      }

      /// loop to sum total amount each month
      for (var i = 0; i < listHeaderMonth.length; i++) {
        for (var j = i; j < listItem.length; j++) {
          if (Utils.dateFormatYearMonth(listHeaderMonth.elementAt(i)) ==
              Utils.dateFormatYearMonth(Utils.dateTimeFormat("${listItem
                  .elementAt(j)
                  .createDate}"))) {
            totalAmountMonth =
                totalAmountMonth + double.parse(Utils.exchangeAmount(listItem
                    .elementAt(j)
                    .currencyCode, listItem
                    .elementAt(j)
                    .amount));
          }
        }
        listTotalEachMonth.add(totalAmountMonth);
        totalAmountMonth = 0.0;
      }
    }
  }

  /// reset all data form list
  resetForm() {
    listHeaderYear.clear();
    listTotalEachYear.clear();
    listTotalEachMonth.clear();
    listHeaderMonth.clear();
    lastHeaderMonth = "";
    lastHeaderYear = "";
    lastWeek = "";
    totalAmountYear = 0.0;
    totalAmountMonth = 0.0;
  }

  @override
  void initState() {
    super.initState();
    loadExpense('1');
    initBannerAd();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).copyWith(dividerColor: Colors.transparent);

    setState(() {
      resetForm();
      loadForm();
    });

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
          child: ExpenseToggle(
            defaultIndex: toggleIndex,
            isAll: false,
            onToggle: (int index) {
              if (toggleIndex != index) {
                listItem.clear();
                toggleIndex = index;
                // loadExpense(index == 0 ? '' : index.toString());
                loadExpense(index == 0 ? '1' : '2');

                if(scrollController.hasClients) {
                  final position = scrollController.position.minScrollExtent;
                  scrollController.jumpTo(position);
                }
              }
            },
          ),
        ),
        Expanded(
            child: ListView.builder(
                controller: scrollController,
                itemCount: listHeaderYear.length,
                itemBuilder: (BuildContext context, int yearIndex) {
                  return StickyHeader(
                      header: Column(
                        children: [
                          Container(
                              color: MyColors.greyBackground,
                              padding: const EdgeInsets.only(left: 20, top: 17, right: 20, bottom: 7),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(listHeaderYear.elementAt(yearIndex), style: MyTextStyles.textStyleBold17),
                                  Text('${Utils.formatSymbol(toggleIndex)}${Utils.formatCurrency(listTotalEachYear.elementAt(yearIndex).toString())}', style: toggleIndex == 0 ? MyTextStyles.textStyleMedium17Red : MyTextStyles.textStyleMedium17Green),
                                ],
                              )
                          ),
                          Visibility(
                              visible: listVisibleHeader.elementAt(yearIndex).visible,
                              child: const Divider(
                                color: MyColors.blue,
                                height: 0,
                                thickness: 2
                              )
                          )
                        ],
                      ),
                      content: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: listHeaderMonth.length,
                          itemBuilder: (BuildContext context, int monthIndex) {
                            return listHeaderYear.elementAt(yearIndex) == Utils.dateFormatYear(listHeaderMonth.elementAt(monthIndex)) ?
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Theme(data: theme, child:
                                ExpansionTile(
                                    initiallyExpanded: defaultExpand,
                                    tilePadding: const EdgeInsets.only(right: 20, left: 20),
                                    leading: Text(Utils.dateFormatMonthYear(listHeaderMonth.elementAt(monthIndex)), style: MyTextStyles.textStyleMedium17),
                                    backgroundColor: MyColors.white,
                                    collapsedBackgroundColor: MyColors.white,
                                    trailing: IntrinsicWidth(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Text('${Utils.formatSymbol(toggleIndex)}${Utils.formatCurrency(listTotalEachMonth.elementAt(monthIndex).toString())}', style: toggleIndex == 0 ? MyTextStyles.textStyleMedium17Red : MyTextStyles.textStyleMedium17Green),
                                            const SizedBox(width: 11),
                                            SvgPicture.asset('assets/images/ic_arrow_drop_down.svg')
                                          ],
                                        )
                                    ),
                                    onExpansionChanged: (value) {
                                      /// set to draw line while item was expand
                                      setState(() {
                                        if (value) {
                                          listCounter.add(yearIndex);
                                          listVisibleHeader.removeAt(yearIndex);
                                          listVisibleHeader.insert(yearIndex, YearHeader(listHeaderYear.elementAt(yearIndex), true));
                                        } else {
                                          listCounter.remove(yearIndex);
                                          if (!listCounter.contains(yearIndex)) {
                                            listVisibleHeader.removeAt(yearIndex);
                                            listVisibleHeader.insert(yearIndex, YearHeader(listHeaderYear.elementAt(yearIndex), false));
                                          }
                                        }
                                      });
                                    },
                                    title: const Text(''),
                                    children: [
                                      SingleChildScrollView(
                                          physics: const ScrollPhysics(),
                                          child: ColoredBox(
                                              color: MyColors.white,
                                              child: ListView.builder(
                                                  physics: const NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemCount: listItem.length,
                                                  itemBuilder: (context, itemIndex) {
                                                    Expenses? childItem = listItem.elementAt(itemIndex);
                                                    String? week = getWeekGroup(Utils.dateFormatDay(Utils.dateTimeFormat("${childItem.createDate}")));
                                                    if (lastWeek != week) {
                                                      print(week);
                                                      lastWeek = week;
                                                      isSameWeek = true;
                                                    } else {
                                                      isSameWeek = false;
                                                    }
                                                    print('>>>> $week');
                                                    return Utils.dateFormatYearMonth(listHeaderMonth.elementAt(monthIndex)) == Utils.dateFormatYearMonth(Utils.dateTimeFormat("${childItem.createDate}")) ?
                                                    isSameWeek? ExpansionTile(
                                                      title: const Text(''),
                                                      tilePadding: const EdgeInsets.only(right: 20, left: 20),
                                                      leading: Text(week, style: MyTextStyles.textStyleMedium17),
                                                      trailing: IntrinsicWidth(
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.end,
                                                            children: [
                                                              Text('', style: toggleIndex == 0 ? MyTextStyles.textStyleMedium17Red : MyTextStyles.textStyleMedium17Green),
                                                              const SizedBox(width: 11),
                                                              SvgPicture.asset('assets/images/ic_arrow_drop_down.svg')
                                                            ],
                                                          )
                                                      ),
                                                      children: [
                                                        Column(
                                                          children: [
                                                            ListItem(
                                                              item: childItem,
                                                              onItemSelected: (Expenses? value) {
                                                                _navigationRoute(context, value);
                                                              },
                                                            ),
                                                            Utils.dateFormatYearMonth(Utils.dateTimeFormat("${listItem.elementAt(itemIndex < listItem.length - 1 ? itemIndex + 1 : itemIndex).createDate}")) != Utils.dateFormatYearMonth(listHeaderMonth.elementAt(monthIndex)) ? const SizedBox()
                                                                : childItem == listItem.last ? const SizedBox() : Container(
                                                                padding: const EdgeInsets.only(left: 70),
                                                                child: const Divider(
                                                                    color: MyColors.greyBackground,
                                                                    height: 0,
                                                                    thickness: 1
                                                                )
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    ) : const SizedBox() : const SizedBox();
                                                  }
                                              )
                                          )
                                      )
                                    ])),
                                const SizedBox(height: 5)
                              ],
                            )
                                : const SizedBox();
                          })
                  );
                }
            )
        ),
        ColoredBox(
          color: Colors.white,
          child: SizedBox(
            height: bannerAd.size.height.toDouble(),
            width: double.infinity,
            child: AdWidget(ad: bannerAd),
          ),
        )
      ],
    );
  }
}

String getWeekGroup(String day) {
  var week = '';
  switch(day) {
    case '01':
    case '02':
    case '03':
    case '04':
    case '05':
    case '06':
    case '07': {
      week = 'Week 1';
    } break;
    case '08':
    case '09':
    case '10':
    case '11':
    case '12':
    case '13':
    case '14': {
      week = 'Week 2';
    } break;
    case '15':
    case '16':
    case '17':
    case '18':
    case '19':
    case '20':
    case '21': {
      week = 'Week 3';
    } break;
    default : {
      week = 'Week 4';
    } break;
  }
  return week;
}

/// call back route page
Future<void> _navigationRoute(BuildContext context, Expenses? param) async {
  Navigator.of(context).push(_createRoute(param));
}

/// animation route page
Route _createRoute(Expenses? param) {
  return PageRouteBuilder(
      settings: RouteSettings(arguments: param),
      pageBuilder: (context, animation, secondaryAnimation) => const CreatePage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      }
  );
}