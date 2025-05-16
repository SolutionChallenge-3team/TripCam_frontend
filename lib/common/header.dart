import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return const Positioned(
      top: 0,
      left: 10,
      child: Text(
        'Trip Cam',
        style: TextStyle(
          fontFamily: 'KronaOne',
          fontSize: 25,
          fontWeight: FontWeight.w400,
          letterSpacing: -0.5,
          color: Color(0xFF2449FF),
        ),
      ),
    );
  }
}
