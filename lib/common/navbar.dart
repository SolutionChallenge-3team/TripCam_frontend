import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // TODO: 화면 이동 또는 콜백 연결도 여기서 처리 가능
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 배경 라인
        Positioned(
          left: 0,
          top: 660,
          width: 410,
          height: 1,
          child: Container(color: const Color.fromRGBO(173, 173, 173, 0.5)),
        ),
        // 네비게이션 바 전체 영역
        Positioned(
          left: 0,
          top: 500,
          width: 385,
          height: 59,
          child: Container(color: Colors.transparent),
        ),
        // 아이콘들 배치
        Positioned(
          left: 30,
          top: 689,
          width: 345,
          height: 30,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _NavIcon(
                icon: Icons.home,
                isActive: _selectedIndex == 0,
                onTap: () => _onTap(0),
              ),
              _NavIcon(
                icon: Icons.camera_alt,
                isActive: _selectedIndex == 1,
                onTap: () => _onTap(1),
              ),
              _NavIcon(
                icon: Icons.calendar_month,
                isActive: _selectedIndex == 2,
                onTap: () => _onTap(2),
              ),
              _NavIcon(
                icon: Icons.person,
                isActive: _selectedIndex == 3,
                onTap: () => _onTap(3),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _NavIcon extends StatelessWidget {
  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;

  const _NavIcon({
    required this.icon,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 30,
        height: 30,
        child: Icon(
          icon,
          size: 28,
          color: isActive ? const Color(0xFF2449FF) : const Color(0xFF757575),
        ),
      ),
    );
  }
}
