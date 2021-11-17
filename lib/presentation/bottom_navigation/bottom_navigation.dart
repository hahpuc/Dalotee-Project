import 'package:dalotee/presentation/pages/daily_tab/daily_page.dart';
import 'package:dalotee/presentation/pages/profile_tab/profile_page.dart';
import 'package:dalotee/presentation/pages/spread_tab/spread_page.dart';
import 'package:dalotee/presentation/pages/tarot_card_tab/tarot_card_page.dart';
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
        height: 80,
        child: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: Colors.white,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Text('Daily'), label: 'Daily'),
            BottomNavigationBarItem(
              icon: Text('Card'),
              label: 'Tarot Card',
            ),
            BottomNavigationBarItem(
              icon: Text('Spread'),
              label: 'Spread',
            ),
            BottomNavigationBarItem(
              icon: Text('Profile'),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedIconTheme:
              IconThemeData(color: Colors.amber, opacity: 1.0, size: 45),
          unselectedIconTheme:
              IconThemeData(color: Colors.black45, opacity: 0.5, size: 25),
          // unselectedItemColor: const Color(0xFF8E8E93),
          // selectedItemColor: const Color(0xFFFFFFFF),
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
        return TarotCardPage();
      case 2:
        return SpreadPage();
      case 3:
        return ProfilePage();
      default:
    }
  }
}
