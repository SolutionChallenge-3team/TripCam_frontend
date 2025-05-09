import 'package:flutter/material.dart';
import 'package:tripcam/common/theme.dart';

class ShutterButton extends StatelessWidget {
  final VoidCallback onTap;

  const ShutterButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 75,
        height: 75,
        decoration: const BoxDecoration(
          color: AppColors.main,
          shape: BoxShape.circle,
        ),
        child: const Center(
          child: Icon(Icons.camera_alt, size: 32, color: Colors.white),
        ),
      ),
    );
  }
}
