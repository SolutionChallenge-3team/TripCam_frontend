import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:tripcam/common/theme.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with TickerProviderStateMixin {
  late final List<AnimationController> _controllers;
  late final List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();

    _controllers = List.generate(3, (i) {
      return AnimationController(
        duration: const Duration(milliseconds: 1200),
        vsync: this,
      );
    });

    _animations =
        _controllers.map((controller) {
          return Tween<double>(begin: 1.0, end: 1.25).animate(
            CurvedAnimation(parent: controller, curve: Curves.easeInOutBack),
          );
        }).toList();

    for (int i = 0; i < _controllers.length; i++) {
      Future.delayed(Duration(milliseconds: i * 300), () {
        if (mounted) {
          _controllers[i].repeat(reverse: true);
        }
      });
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Align(
            alignment: Alignment.center,
            child: FractionallySizedBox(
              widthFactor: 1.0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 애니메이션 원들
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildAnimatedDot(_animations[0], size: 15),
                      const SizedBox(width: 36),
                      _buildAnimatedDot(_animations[1], size: 20),
                      const SizedBox(width: 36),
                      _buildAnimatedDot(_animations[2], size: 25),
                    ],
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    '장소의 기억을 불러오는 중이예요...',
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const SizedBox(
                    width: 240,
                    child: Text(
                      'AI가 이 장소의 숨겨진 이야기를 정리하고 있어요',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF757575),
                        letterSpacing: -0.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAnimatedDot(
    Animation<double> animation, {
    required double size,
  }) {
    return ScaleTransition(
      scale: animation,
      child: Container(
        width: size,
        height: size,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.main, Color(0xFF567DFF)],
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0x332449FF),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
      ),
    );
  }
}
