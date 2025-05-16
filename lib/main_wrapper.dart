import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth/login.dart';
import 'common/navbar.dart';
import 'home/home.dart';
import 'calendar/calendar_screen.dart';
import 'settings/settinig_list.dart';
import 'recomend/recommend_screen.dart';
import 'camera/camera_screen.dart';
import 'settings/profile.dart';
import 'dart:async';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  User? _user;
  late final StreamSubscription<User?> _authStateSub;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser;

    _authStateSub = FirebaseAuth.instance.authStateChanges().listen((user) {
      setState(() {
        _user = user;
      });
    });
  }

  @override
  void dispose() {
    _authStateSub.cancel();
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CameraScreen()),
      );
      return;
    }

    if (index == 3) {
      final displayName = _user?.displayName ?? '사용자';
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfileScreen(displayName: displayName),
        ),
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
        return const Home();
      default:
        return const Home();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null) {
      return const LoginScreen();
    }

    return Scaffold(
      body: _getScreenByIndex(_selectedIndex),
      bottomNavigationBar: NavBar(
        selectedIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
