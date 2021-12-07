import 'package:dalotee/generated/assets/assets.gen.dart';
import 'package:dalotee/presentation/pages/daily_tab/daily_page.dart';
import 'package:dalotee/presentation/pages/profile_tab/profile_page.dart';
import 'package:dalotee/presentation/pages/search_tab/search_page.dart';
import 'package:dalotee/presentation/pages/spread_tab/spread_page.dart';
import 'package:dalotee/values/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

/// This is the private State class that goes with BottomNavigation.
class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: SizedBox(
        child: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Image(
                image: Assets.images.icDaily,
                width: 32.0,
                height: 32.0,
                color: _selectedIndex == 0
                    ? AppColor.colorSelected
                    : AppColor.colorUnselected,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Image(
                image: Assets.images.icSearch,
                width: 32.0,
                height: 32.0,
                color: _selectedIndex == 1
                    ? AppColor.colorSelected
                    : AppColor.colorUnselected,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Image(
                image: Assets.images.icSpread,
                width: 32.0,
                height: 32.0,
                color: _selectedIndex == 2
                    ? AppColor.colorSelected
                    : AppColor.colorUnselected,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Image(
                image: Assets.images.icProfile,
                width: 32.0,
                height: 32.0,
                color: _selectedIndex == 3
                    ? AppColor.colorSelected
                    : AppColor.colorUnselected,
              ),
              label: '',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }

  getBody() {
    switch (_selectedIndex) {
      case 0:
        return DailyPage();
      case 1:
        return SearchPage();
      case 2:
        return SpreadPage();
      case 3:
        return ProfilePage();
      default:
    }
  }
}
