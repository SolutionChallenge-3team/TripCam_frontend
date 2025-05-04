import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return const Positioned(
      left: 20,
      top: -1.5,
      child: Text(
        'Trip Cam',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'KronaOne',
          fontSize: 25,
          height: 1.0,
          fontWeight: FontWeight.w400,
          letterSpacing: -0.5,
          color: Color(0xFF2449FF),
        ),
      ),
    );
  }
}
