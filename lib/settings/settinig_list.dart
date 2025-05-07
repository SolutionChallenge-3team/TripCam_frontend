import 'package:flutter/material.dart';
import 'package:tripcam/settings/logout_setting.dart';
import 'package:tripcam/settings/logout.dart';
import 'package:tripcam/settings/nickname.dart';
import 'package:tripcam/settings/withdraw.dart';
import '../common/theme.dart';
import '../common/button.dart';

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
          Positioned(
            left: 33,
            top: 220,
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  barrierColor: Colors.black.withOpacity(0.5),
                  barrierDismissible: true,
                  builder:
                      (context) => LogoutSetting(
                        onConfirm: () {
                          Navigator.of(context).pop();
                          // 로그아웃 처리
                        },
                        onCancel: () {
                          Navigator.of(context).pop();
                        },
                      ),
                );
              },
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 66,
                height: 32,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      '로그아웃',
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                        letterSpacing: -0.5,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(width: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
