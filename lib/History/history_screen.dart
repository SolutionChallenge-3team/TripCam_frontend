import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tripcam/common/button.dart';
import 'package:tripcam/recomend/recommend_screen.dart';

class HistoryScreen extends StatelessWidget {
  final File? imageFile;
  final String? locationName;
  final String? description;
  final String? story;
  final List<dynamic>? recommendations;

  const HistoryScreen({
    super.key,
    this.imageFile,
    this.locationName,
    this.description,
    this.story,
    this.recommendations,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios),
                          onPressed: () => Navigator.pop(context),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          locationName ?? '알 수 없는 장소',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Pretendard',
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const Icon(
                      Icons.home_outlined,
                      color: Colors.black,
                      size: 28,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFFD9D9D9)),
                    color: Colors.grey[200],
                    image:
                        imageFile != null
                            ? DecorationImage(
                              image: FileImage(imageFile!),
                              fit: BoxFit.cover,
                            )
                            : null,
                  ),
                  child:
                      imageFile == null
                          ? const Center(
                            child: Icon(
                              Icons.image,
                              size: 50,
                              color: Colors.grey,
                            ),
                          )
                          : null,
                ),
                const SizedBox(height: 32),
                if (description != null) ...[
                  const Text(
                    '설명',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Pretendard',
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description!,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Pretendard',
                      color: Colors.black87,
                      height: 1.6,
                    ),
                  ),
                ],
                const SizedBox(height: 24),
                if (story != null) ...[
                  const Text(
                    '역사 이야기',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Pretendard',
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    story!,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Pretendard',
                      color: Colors.black87,
                      height: 1.6,
                    ),
                  ),
                ],
                const SizedBox(height: 40),
                RecommendPlaceButton(
                  onTap: () {
                    if (recommendations != null &&
                        recommendations!.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RecommendScreen(),
                          settings: RouteSettings(arguments: recommendations),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('추천 장소가 없습니다.')),
                      );
                    }
                  },
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
