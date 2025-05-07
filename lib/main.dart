import 'package:flutter/material.dart';
import 'package:tripcam/settings/logout_setting.dart';
import 'package:tripcam/settings/settinig_list.dart';
import 'common/theme.dart';
import 'settings/nickname_setting.dart';
import 'home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TripCam',
      debugShowCheckedModeBanner: false,
      theme: Appfonts.lightTheme,
      home: const SettingsList(),
      routes: {'/nickname': (context) => const NicknameSetting()},
    );
  }
}
