import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import '../common/shutter_button.dart';
import '../common/camera_bar.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _controller;
  List<CameraDescription> _cameras = [];
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    // 시뮬레이터인지 확인
    if (Platform.isIOS && !Platform.isMacOS && !Platform.isAndroid) {
      print('시뮬레이터에서는 카메라를 초기화하지 않습니다.');
      setState(() {
        _isInitialized = true; // UI 테스트용으로만 사용
      });
    } else {
      await _initializeCamera();
    }
  }

  Future<void> _initializeCamera() async {
    try {
      print('카메라 초기화 시작');
      _cameras = await availableCameras();
      print('카메라 수: ${_cameras.length}');

      if (_cameras.isEmpty) {
        print('사용 가능한 카메라가 없습니다.');
        return;
      }

      _controller = CameraController(_cameras[0], ResolutionPreset.high);
      await _controller!.initialize();
      setState(() {
        _isInitialized = true;
      });
      print('카메라 초기화 완료');
    } catch (e) {
      print('카메라 초기화 중 오류 발생: $e');
    }
  }

  void _pickImageFromGallery() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      print('선택한 이미지: ${image.path}');
      // TODO: 이미지 처리
    }
  }

  void _switchCamera() async {
    if (_controller == null) return;
    final currentLens = _controller!.description.lensDirection;
    final newCamera = _cameras.firstWhere(
      (cam) => cam.lensDirection != currentLens,
      orElse: () => _cameras[0],
    );
    await _controller!.dispose();
    _controller = CameraController(newCamera, ResolutionPreset.high);
    await _controller!.initialize();
    setState(() {});
  }

  void _toggleFlash() async {
    if (_controller == null) return;
    final flashMode = _controller!.value.flashMode;
    final newMode =
        flashMode == FlashMode.off ? FlashMode.torch : FlashMode.off;
    await _controller!.setFlashMode(newMode);
  }

  void _takePicture() async {
    if (_controller == null ||
        !_controller!.value.isInitialized ||
        _controller!.value.isTakingPicture)
      return;

    try {
      final picture = await _controller!.takePicture();
      print('사진 저장 경로: ${picture.path}');
      // TODO: 촬영된 사진 활용
    } catch (e) {
      print('촬영 실패: $e');
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body:
          _isInitialized
              ? Stack(
                children: [
                  _controller != null
                      ? SizedBox.expand(child: CameraPreview(_controller!))
                      : Container(color: Colors.black), //에뮬레이터 배경

                  Positioned(
                    top: 71,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: CameraActionBar(
                        onGalleryTap: _pickImageFromGallery,
                        onSwitchCamera: _switchCamera,
                        onToggleFlash: _toggleFlash,
                        onClose: () => Navigator.pop(context),
                      ),
                    ),
                  ),

                  Positioned(
                    bottom: 40,
                    left: 0,
                    right: 0,
                    child: Center(child: ShutterButton(onTap: _takePicture)),
                  ),
                ],
              )
              : const Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
    );
  }
}
