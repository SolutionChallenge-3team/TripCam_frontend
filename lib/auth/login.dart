import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:tripcam/home/home.dart';
import 'package:tripcam/common/button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  Future<void> _handleGoogleSignIn(BuildContext context) async {
    final googleSignIn = GoogleSignIn();
    final firebaseAuth = FirebaseAuth.instance;

    try {
      await googleSignIn.signOut();
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await firebaseAuth.signInWithCredential(
        credential,
      );

      final idToken = await userCredential.user?.getIdToken();
      if (idToken == null) throw Exception("ID 토큰 없음");

      print("보내는 토큰: $idToken");
      print("요청 중...");

      final response = await http.post(
        Uri.parse('http://10.50.104.95:8080/auth/firebase'),
        headers: {'Content-Type': 'text/plain'},
        body: idToken,
      );

      print("응답 코드: \${response.statusCode}");
      print("응답 바디: \${response.body}");

      if (response.statusCode == 200) {
        final jwt = response.body;
        print("백엔드에서 받은 JWT: $jwt");

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Home()),
        );
      } else {
        print('백엔드 응답 오류: \${response.body}');
        _showErrorDialog(context, '서버 인증 실패');
      }
    } catch (e) {
      print('Google Sign-In Error: $e');
      _showErrorDialog(context, '로그인 중 오류 발생');
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text('에러'),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('확인'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            const Center(
              child: Text(
                'Trip Cam',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'KronaOne',
                  letterSpacing: -0.5,
                  color: Color(0xFF2449FF),
                ),
              ),
            ),
            Positioned(
              left: 20,
              right: 20,
              bottom: 45,
              child: LoginButton(onTap: () => _handleGoogleSignIn(context)),
            ),
          ],
        ),
      ),
    );
  }
}
