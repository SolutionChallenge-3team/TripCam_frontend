import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../common/button.dart';

class ProfileScreen extends StatefulWidget {
  final String displayName;

  const ProfileScreen({super.key, required this.displayName});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _profileImage;
  late String _nickname;

  @override
  void initState() {
    super.initState();
    _nickname = widget.displayName;
  }

  Future<void> _pickProfileImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _profileImage = File(image.path);
      });
    }
  }

  Future<void> _goToNicknameEditScreen() async {
    final result = await Navigator.pushNamed(context, '/nickname');
    if (result != null && result is String) {
      setState(() {
        _nickname = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            const Positioned(
              left: 14,
              top: 17,
              child: SizedBox(width: 31, height: 32, child: CommonBackButton()),
            ),

            Positioned(
              top: 50,
              left: MediaQuery.of(context).size.width / 2 - 38,
              child: GestureDetector(
                onTap: _pickProfileImage,
                child: CircleAvatar(
                  radius: 38,
                  backgroundColor: const Color(0xFFD9D9D9),
                  backgroundImage:
                      _profileImage != null ? FileImage(_profileImage!) : null,
                  child:
                      _profileImage == null
                          ? const Icon(
                            Icons.person,
                            size: 40,
                            color: Colors.white,
                          )
                          : null,
                ),
              ),
            ),

            Positioned(
              top: 150,
              left: 15,
              right: 0,
              child: Center(
                child: GestureDetector(
                  onTap: _goToNicknameEditScreen,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _nickname,
                        style: const TextStyle(
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.edit, size: 18, color: Colors.grey),
                    ],
                  ),
                ),
              ),
            ),

            Positioned(
              top: 200,
              left: 37,
              right: 37,
              child: Container(
                height: 43,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFD9D9D9)),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: const [
                    SizedBox(width: 16),
                    Icon(Icons.email, size: 20, color: Color(0xFF757575)),
                    SizedBox(width: 12),
                    Text(
                      'tripcam@gmail.com',
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF757575),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
