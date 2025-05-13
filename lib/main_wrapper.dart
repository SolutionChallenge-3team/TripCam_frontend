import 'package:flutter/material.dart';
import 'common/navbar.dart';
import 'home.dart';
import 'calendar/calendar_screen.dart';
import 'settings/settinig_list.dart';
import 'recomend/recommend_screen.dart';
import 'camera/camera_screen.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CameraScreen()),
      );
      return;
    }

    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _getScreenByIndex(int index) {
    switch (index) {
      case 0:
        return const Home();
      case 2:
        return const CalendarScreen();
      case 3:
        return const SettingsList();
      default:
        return const Home();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getScreenByIndex(_selectedIndex),
      bottomNavigationBar: NavBar(
        selectedIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
