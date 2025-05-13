import 'package:flutter/material.dart';
import 'package:tripcam/settings/logout_setting.dart';
import 'package:tripcam/settings/logout.dart';
import 'package:tripcam/settings/nickname.dart';
import 'package:tripcam/settings/withdraw.dart';
import 'package:tripcam/settings/profile.dart';
import 'package:tripcam/settings/withdraw_setting.dart';
import '../common/theme.dart';
import '../common/button.dart';

class SettingsList extends StatelessWidget {
  const SettingsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: Center(
                child: Text(
                  '설정',
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.5,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),

            SettingItem(
              title: '사용자 정보',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileScreen(),
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

            SettingItem(
              title: '로그아웃',
              onTap: () {
                showDialog(
                  context: context,
                  barrierColor: Colors.black.withOpacity(0.5),
                  barrierDismissible: true,
                  builder:
                      (context) => LogoutSetting(
                        onConfirm: () {
                          Navigator.of(context).pop();
                          // 로그아웃 로직
                        },
                        onCancel: () => Navigator.of(context).pop(),
                      ),
                );
              },
            ),

            const SizedBox(height: 20),

            SettingItem(
              title: '탈퇴하기',
              onTap: () {
                showDialog(
                  context: context,
                  barrierColor: Colors.black.withOpacity(0.5),
                  barrierDismissible: true,
                  builder:
                      (context) => WithdrawSetting(
                        onConfirm: () {
                          Navigator.of(context).pop();
                        },
                        onCancel: () => Navigator.of(context).pop(),
                      ),
                );
              },
              textColor: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}

class SettingItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final Color textColor;

  const SettingItem({
    super.key,
    required this.title,
    required this.onTap,
    this.textColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 33),
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          height: 32,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                  letterSpacing: -0.5,
                  color: textColor,
                ),
              ),
              const SizedBox(width: 20),
            ],
          ),
        ),
      ),
    );
  }
}
