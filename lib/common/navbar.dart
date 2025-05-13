import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const NavBar({super.key, required this.selectedIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: Color.fromRGBO(173, 173, 173, 0.5)),
        ),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _NavIcon(
              icon: Icons.home,
              isActive: selectedIndex == 0,
              onTap: () => onTap(0),
            ),
            _NavIcon(
              icon: Icons.camera_alt,
              isActive: selectedIndex == 1,
              onTap: () => onTap(1),
            ),
            _NavIcon(
              icon: Icons.calendar_month,
              isActive: selectedIndex == 2,
              onTap: () => onTap(2),
            ),
            _NavIcon(
              icon: Icons.settings,
              isActive: selectedIndex == 3,
              onTap: () => onTap(3),
            ),
          ],
        ),
      ),
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
        width: 80,
        height: 60,
        child: Align(
          alignment: const Alignment(0, -0.3),
          child: Icon(
            icon,
            size: 30,
            color: isActive ? const Color(0xFF2449FF) : const Color(0xFF757575),
          ),
        ),
      ),
    );
  }
}
