import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../common/button.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

Future<void> requestRecommendation(int photoId) async {
  final uri = Uri.parse('http://10.50.104.95/api/photo/recommend');
  final response = await http.post(
    uri,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'photoId': photoId}),
  );

  if (response.statusCode == 200) {
    final result = jsonDecode(response.body);
    print(result);
  } else {
    print('추천 실패: ${response.statusCode}');
  }
}

Future<void> analyzePhotoFromBytes(Uint8List imageBytes, int photoId) async {
  final uri = Uri.parse('http://10.50.104.95:8080/api/photo/analyze');

  final request =
      http.MultipartRequest('POST', uri)
        ..fields['photoId'] = photoId.toString()
        ..files.add(
          http.MultipartFile.fromBytes(
            'image',
            imageBytes,
            filename: 'image.jpg',
          ),
        );

  final response = await request.send();

  if (response.statusCode == 200) {
    print('분석 성공');
  } else {
    print('분석 실패: ${response.statusCode}');
  }
}

Future<List<dynamic>> fetchRecommendedPlaces(int photoId) async {
  final uri = Uri.parse('http://10.50.104.95:8080/api/photo/recommend');

  final response = await http.post(
    uri,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'photoId': photoId}),
  );

  print('서버 응답 Content-Type: ${response.headers['content-type']}');
  print('raw response.body: ${response.body}');
  print('response.bodyBytes: ${response.bodyBytes}');

  if (response.statusCode == 200) {
    final decodedBody = utf8.decode(response.bodyBytes);
    print('decodedBody: $decodedBody'); //

    final List<dynamic> data = jsonDecode(decodedBody);
    return data;
  } else {
    throw Exception('추천 장소 요청 실패: ${response.statusCode}');
  }
}

class RecommendScreen extends StatelessWidget {
  const RecommendScreen({super.key});

  void goToRecommendationScreen(BuildContext context, int photoId) async {
    try {
      final recommendations = await fetchRecommendedPlaces(photoId);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const RecommendScreen(),
          settings: RouteSettings(arguments: recommendations),
        ),
      );
    } catch (e) {
      print('추천 장소 로딩 실패: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('추천 장소를 불러오는 데 실패했습니다.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<dynamic> recommendations =
        ModalRoute.of(context)!.settings.arguments as List<dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: const Text('추천 장소'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: recommendations.length,
        itemBuilder: (context, index) {
          final place = recommendations[index];
          final recommendationId = place['recommendationId'];
          final name = place['recommendedName'] ?? '';
          final description = place['recommendedDescription'] ?? '';
          final latitude = place['latitude']?.toString() ?? '';
          final longitude = place['longitude']?.toString() ?? '';

          if (latitude.isEmpty || longitude.isEmpty) return SizedBox();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${index + 1}. $name',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.all(14),
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFD9D9D9)),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        height: 1.6,
                        fontFamily: 'Pretendard',
                      ),
                    ),
                    const SizedBox(height: 12),
                    GestureDetector(
                      onTap: () async {
                        final mapUrl =
                            'https://maps.google.com/?q=$latitude,$longitude';
                        final uri = Uri.parse(mapUrl);
                        if (await canLaunchUrl(uri)) {
                          await launchUrl(uri);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('지도를 열 수 없습니다.')),
                          );
                        }
                      },

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Icon(Icons.map_outlined, color: Colors.blue),
                          SizedBox(width: 4),
                          Text(
                            '지도 열기',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
