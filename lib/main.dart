import 'package:flutter/material.dart';
import 'common/theme.dart';
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
      home: const Home(),
    );
  }
}
