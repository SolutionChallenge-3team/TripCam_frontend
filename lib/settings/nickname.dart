import 'package:flutter/material.dart';

class Nickname extends StatelessWidget {
  final VoidCallback onTap;

  const Nickname({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 33,
      top: 160,
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          width: MediaQuery.of(context).size.width - 66,
          height: 32,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '닉네임 변경',
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                  letterSpacing: -0.5,
                  color: Colors.black,
                ),
              ),
              Transform.rotate(
                angle: 3.1416,
                child: const Icon(Icons.arrow_back_ios_new, size: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
