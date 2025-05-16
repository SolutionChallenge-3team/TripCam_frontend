import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;
import '../common/shutter_button.dart';
import '../common/camera_bar.dart';
import 'package:tripcam/History/history_screen.dart';
import 'package:tripcam/loding/loading_screen.dart';

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
    if (Platform.isIOS && !Platform.isMacOS && !Platform.isAndroid) {
      setState(() {
        _isInitialized = true;
      });
    } else {
      await _initializeCamera();
    }
  }

  Future<void> _initializeCamera() async {
    try {
      _cameras = await availableCameras();
      if (_cameras.isEmpty) return;

      _controller = CameraController(_cameras[0], ResolutionPreset.high);
      await _controller!.initialize();
      setState(() {
        _isInitialized = true;
      });
    } catch (e) {
      print('카메라 초기화 오류: $e');
    }
  }

  Future<Map<String, dynamic>?> _uploadPhotoForAnalysis(File imageFile) async {
    final uri = Uri.parse('http://10.50.104.95:8080/api/photo/analyze');
    final request = http.MultipartRequest('POST', uri)
      ..files.add(await http.MultipartFile.fromPath('image', imageFile.path));

    try {
      final response = await request.send();
      final responseData = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        return jsonDecode(responseData);
      } else {
        print('서버 오류: $responseData');
        return null;
      }
    } catch (e) {
      print('업로드 실패: $e');
      return null;
    }
  }

  Future<List<dynamic>> fetchRecommendedPlaces(int photoId) async {
    final uri = Uri.parse('http://10.50.104.95:8080/api/photo/recommend');
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'photoId': photoId}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('추천 장소 요청 실패: ${response.statusCode}');
    }
  }

  void _takePicture() async {
    if (_controller == null || !_controller!.value.isInitialized) return;

    final picture = await _controller!.takePicture();
    final file = File(picture.path);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const LoadingScreen(),
    );

    try {
      final analysisData = await _uploadPhotoForAnalysis(file);

      if (!mounted) return;
      Navigator.pop(context);

      if (analysisData == null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('사진 분석 실패')));
        return;
      }

      print('[분석 결과]');
      print('photoId: ${analysisData['photoId']}');
      print('locationName: ${analysisData['locationName']}');
      print('description: ${analysisData['description']}');
      print('story: ${analysisData['story']}');

      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (context) => HistoryScreen(
                imageFile: file,
                locationName: analysisData['locationName'],
                description: analysisData['description'],
                story: analysisData['story'],
                recommendations: null,
              ),
        ),
      );
    } catch (e) {
      if (mounted) Navigator.pop(context);
      print('에러 발생: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('에러: ${e.toString()}')));
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
                      : Container(color: Colors.black),
                  Positioned(
                    top: 71,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: CameraActionBar(
                        onGalleryTap: () {},
                        onSwitchCamera: () {},
                        onToggleFlash: () {},
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
