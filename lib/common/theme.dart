import 'package:flutter/material.dart';

class AppColors {
  // 배경 색
  static const Color background = Color(0xFFFFFFFF);

  // 기본 텍스트 색
  static const Color primaryText = Color(0xFF000000);

  // 서브 텍스트 색 (설명 텍스트, 비활성화 텍스트)
  static const Color subText = Color(0xFFD9D9D9);

  // 메인 브랜드 컬러 (버튼, 액션 강조)
  static const Color main = Color(0xFF0000EF);

  // 서브 브랜드 컬러 (hover, border 등)
  static const Color sub = Color(0xFF2449FF);
}

class AppBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(color: AppColors.background);
  }
}

class Appfonts {
  static final ThemeData lightTheme = ThemeData(
    fontFamily: 'Pretendard',
    scaffoldBackgroundColor: Colors.white,
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w400),
      bodyLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      bodyMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
      bodySmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
    ),
  );
}
