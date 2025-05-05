import 'package:flutter/material.dart';

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
