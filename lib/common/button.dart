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
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios_new),
      color: color,
      iconSize: 20,
      onPressed: onPressed ?? () => Navigator.pop(context),
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
