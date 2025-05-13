import 'package:flutter/material.dart';
import 'package:tripcam/common/theme.dart';

class CommonBackButton extends StatelessWidget {
  final Color color;
  final VoidCallback? onPressed;

  const CommonBackButton({
    super.key,
    this.color = Colors.black,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed ?? () => Navigator.pop(context),
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Icon(Icons.arrow_back_ios_new, color: color, size: 20),
      ),
    );
  }
}

class NicknameButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const NicknameButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.sub,
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'Pretendard',
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
      ),
    );
  }
}

class RecommendPlaceButton extends StatelessWidget {
  final VoidCallback? onTap;

  const RecommendPlaceButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 160,
          height: 48,
          decoration: BoxDecoration(
            color: const Color(0xFF2449FF),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: const Color(0x332449FF),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.place_outlined, size: 20, color: Colors.white),
              SizedBox(width: 8),
              Text(
                '추천 플레이스',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontFamily: 'Pretendard',
                  letterSpacing: -0.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
