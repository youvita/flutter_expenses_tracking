import 'package:expenses_tracking/constand/constand.dart';
import 'package:expenses_tracking/features/expenses/presentation/create/page/create_page.dart';
import 'package:expenses_tracking/features/expenses/presentation/list/page/list_page.dart';
import 'package:expenses_tracking/features/reports/presentation/home/page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  State<StatefulWidget> createState() => _BottomNavigationBarState();
}

class _BottomNavigationBarState extends State<BottomNavigationBarWidget> {

  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[ListPage(), CreatePage(), ReportHomePage()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
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
                      gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          stops: [0.6, 1.0],
                          tileMode: TileMode.mirror,
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
    );
  }

}

/// call back route page
Future<void> _navigationRoute(BuildContext context) async {
  Navigator.of(context).push(_createRoute());
}

/// animation route page
Route _createRoute() {
  return PageRouteBuilder(
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