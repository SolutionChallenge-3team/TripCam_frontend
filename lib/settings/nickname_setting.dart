import 'package:flutter/material.dart';
import '../common/theme.dart';
import '../common/button.dart';

class NicknameSetting extends StatelessWidget {
  const NicknameSetting({super.key});

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

          // 닉네임 변경 타이틀
          const Positioned(
            top: 83,
            left: -10,
            right: 0,
            child: Center(
              child: Text(
                '닉네임 변경',
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

          // 닉네임 입력창
          const Positioned(
            top: 160,
            left: 33,
            right: 33,
            child: TextField(
              cursorColor: AppColors.subText,
              decoration: InputDecoration(
                hintText: '새 닉네임 입력',
                hintStyle: TextStyle(
                  fontFamily: 'Pretendard',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.subText),
                ),
              ),
              style: TextStyle(
                fontFamily: 'Pretendard',
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
          ),

          Positioned(
            top: 280,
            left: 33,
            right: 33,
            child: NicknameButton(
              text: '변경하기',
              onTap: () {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('닉네임이 변경되었습니다!')));
              },
            ),
          ),
        ],
      ),
    );
  }
}
