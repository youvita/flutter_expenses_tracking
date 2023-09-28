import 'package:expenses_tracking/constant/constant.dart';
import 'package:expenses_tracking/database/models/expenses.dart';
import 'package:expenses_tracking/pages/create/create_page.dart';
import 'package:expenses_tracking/pages/home/home_page.dart';
import 'package:expenses_tracking/pages/report/report_page.dart';
import 'package:expenses_tracking/pages/setting/setting_page.dart';
import 'package:expenses_tracking/widgets/default_iOS_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  State<StatefulWidget> createState() => _BottomNavigationBarState();
}

class _BottomNavigationBarState extends State<BottomNavigationBarWidget> {

  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[HomePage(), CreatePage(), ReportPage()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    return CupertinoPageScaffold(
      navigationBar: DefaultIOSAppBar(title: _selectedIndex == 0 ? "Home" : _selectedIndex == 1 ? "Create" : 'Expenses'),
      // navigationBar: CupertinoNavigationBar(
      //   backgroundColor: MyColors.blue,
      //   middle: const Text("Expenses", style: MyTextStyles.appBarTitle,),
      //   trailing: CupertinoButton(
      //     onPressed: (){
      //       Navigator.push(context, CupertinoPageRoute(builder: (context) => const SettingPage()));
      //     },
      //     padding: EdgeInsets.zero,
      //     child: SvgPicture.asset('assets/images/settings-04.svg')
      //   )
      // ),
      child: Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
          // child: BlocProvider(
          //   create: (_) => sl<ListExpenseBloc>()..add(const ListExpenseLoad()),
          //   child: _widgetOptions.elementAt(_selectedIndex),
          // ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedFontSize: 5,
          showSelectedLabels: false,
          backgroundColor: MyColors.white,
          elevation: 0.0,
          items: <BottomNavigationBarItem>[

            BottomNavigationBarItem(
              icon: Column(children: [
                const SizedBox(height: 15),
                Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: _selectedIndex == 0 ? MyColors.blue : MyColors.grey,
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: SvgPicture.asset('assets/images/ic_list.svg', height: 19, width: 19)
                    )
                ),
                Text("Expense", style: TextStyle(fontSize: 11, color: _selectedIndex == 0 ? MyColors.blue : MyColors.grey))
              ]),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: InkWell(
                  borderRadius: BorderRadius.circular(100),
                  onTap: () {
                   _navigationRoute(context);
                  },
                  child: Container(
                      height: 46,
                      width: 46,
                      decoration: const BoxDecoration(
                        gradient: SweepGradient(
                          center: Alignment.topRight,
                            stops: [0.1, 0.8],
                            tileMode: TileMode.clamp,
                            colors: [MyColors.blue, MyColors.white]
                        ),
                        color: MyColors.blue,
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: SvgPicture.asset('assets/images/ic_plus.svg', height: 17, width: 17)
                      )
                  )
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Column(children: [
                const SizedBox(height: 15),
                Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: _selectedIndex == 2 ? MyColors.blue : MyColors.grey,
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: SvgPicture.asset('assets/images/ic_pie-chart.svg', height: 19, width: 19)
                    )
                ),
                Text("Report", style: TextStyle(fontSize: 11, color: _selectedIndex == 2 ? MyColors.blue : MyColors.grey))
              ]),
              label: '',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        )
    )
    ) ;
  }

}

/// call back route page
Future<void> _navigationRoute(BuildContext context) async {
  Navigator.of(context).push(_createRoute());
}

/// animation route page
Route _createRoute() {
  return PageRouteBuilder(
      settings: RouteSettings(arguments: Expenses(null, null, null, null, null, null, null, null, null)),
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