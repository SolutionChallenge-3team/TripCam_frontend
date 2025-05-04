import 'package:flutter/material.dart';
import 'common/theme.dart';
import 'common/navbar.dart';
import 'common/header.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.primaryText),
      ),
      body: Stack(
        children: const [
          Header(), // ✅ 헤더 추가
          Center(child: Text('여기는 홈 화면입니다.')),
          NavBar(), // 네비게이션 바
        ],
      ),
    );
  }
}
