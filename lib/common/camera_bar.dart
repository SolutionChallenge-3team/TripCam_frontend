import 'package:flutter/material.dart';

class CameraActionBar extends StatelessWidget {
  final VoidCallback onGalleryTap;
  final VoidCallback onSwitchCamera;
  final VoidCallback onToggleFlash;
  final VoidCallback onClose;

  const CameraActionBar({
    super.key,
    required this.onGalleryTap,
    required this.onSwitchCamera,
    required this.onToggleFlash,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _iconButton(Icons.photo_library_outlined, onTap: onGalleryTap),
        _iconButton(Icons.cameraswitch, onTap: onSwitchCamera),
        _iconButton(Icons.flash_on, onTap: onToggleFlash),
        _iconButton(Icons.close, onTap: onClose),
      ],
    );
  }

  Widget _iconButton(IconData icon, {required VoidCallback onTap}) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: Icon(icon, size: 20, color: Colors.white),
        onPressed: onTap,
      ),
    );
  }
}
