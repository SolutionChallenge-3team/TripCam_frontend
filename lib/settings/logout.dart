import 'package:flutter/material.dart';
import 'logout_setting.dart';

class Logout extends StatelessWidget {
  const Logout({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
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
    );
  }
}
