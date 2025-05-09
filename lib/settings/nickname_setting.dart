import 'package:flutter/material.dart';
import '../common/theme.dart';
import '../common/button.dart';

class NicknameSetting extends StatefulWidget {
  const NicknameSetting({super.key});

  @override
  State<NicknameSetting> createState() => _NicknameSettingState();
}

class _NicknameSettingState extends State<NicknameSetting> {
  final TextEditingController _controller = TextEditingController();

  void _handleChange() {
    final nickname = _controller.text.trim();
    if (nickname.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('닉네임을 입력해주세요.'),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    // 닉네임 저장 로직 (예: API 호출 등)

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('닉네임이 변경되었습니다!'),
        backgroundColor: AppColors.main,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );

    _controller.clear();
  }

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

          // 타이틀
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
          Positioned(
            top: 160,
            left: 33,
            right: 33,
            child: TextField(
              controller: _controller,
              cursorColor: AppColors.subText,
              decoration: const InputDecoration(
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
              style: const TextStyle(
                fontFamily: 'Pretendard',
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
          ),

          Positioned(
            top: 220,
            left: 33,
            right: 33,
            child: NicknameButton(text: '변경하기', onTap: _handleChange),
          ),
        ],
      ),
    );
  }
}
