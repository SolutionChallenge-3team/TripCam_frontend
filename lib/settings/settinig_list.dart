import 'package:flutter/material.dart';
import 'package:tripcam/settings/logout.dart';
import 'package:tripcam/settings/nickname.dart';
import '../common/theme.dart';
import '../common/button.dart';
import 'nickname.dart';
import 'withdraw.dart';

class SettingsList extends StatelessWidget {
  const SettingsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // 뒤로가기 버튼
          const Positioned(
            left: 14,
            top: 80,
            child: SizedBox(width: 31, height: 32, child: CommonBackButton()),
          ),

          // 설정 타이틀
          const Positioned(
            top: 83,
            left: -10,
            right: 0,
            child: Center(
              child: Text(
                '설정',
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.5,
                  color: Colors.black,
                  height: 1.0,
                ),
              ),
            ),
          ),

          // 닉네임 변경 항목
          Nickname(
            onTap: () {
              Navigator.pushNamed(context, '/nickname');
            },
          ),

          // 탈퇴하기 항목
          WithdrawSetting(
            onTap: () {
              Navigator.pushNamed(context, '/withdraw');
            },
          ),
          // 로그아웃 항목
          Logout(
            onTap: () {
              Navigator.pushNamed(context, '/logout');
            },
          ),
        ],
      ),
    );
  }
}
