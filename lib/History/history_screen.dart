import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tripcam/common/button.dart';
import '../common/button.dart';

class HistoryScreen extends StatelessWidget {
  final File? imageFile;

  const HistoryScreen({super.key, this.imageFile});

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

                // 뒤로가기 버튼 + 제목 + 홈 아이콘
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: const [
                        CommonBackButton(), // ← 위치 맞춤됨
                        SizedBox(width: 12),
                        Text(
                          '에펠탑',
                          style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
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

                const SizedBox(height: 12),

                // 장소 정보
                Row(
                  children: const [
                    Icon(
                      Icons.location_on_outlined,
                      size: 14,
                      color: Colors.grey,
                    ),
                    SizedBox(width: 4),
                    Text(
                      '샹드 마르스 공원, 파리',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                        fontFamily: 'Pretendard',
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // 이미지
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

                // 소제목 + 요약 설명
                const Text(
                  '에펠탑의 역사',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                    fontFamily: 'Pretendard',
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  '박람회 전시물이었던 에펠탑은, 무선 통신의 요충지로 재탄생하며 파리의 상징으로 남게 되었습니다.',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontFamily: 'Pretendard',
                    letterSpacing: -0.5,
                    height: 1.6,
                  ),
                ),

                const SizedBox(height: 32),

                // 상세 설명
                const Text(
                  '그 시작은 1889년 세계박람회였습니다. 19세기 말, 프랑스는 기술력을 세계에 보여줄 무언가가 필요했어요. '
                  '그 답이 바로 이 거대한 철탑이었죠. 그러나 시민들의 반응은 싸늘했어요. '
                  '"파리의 미관을 해치는 흉물"이라는 비난도 많았고, 20년 뒤 철거될 예정이었답니다. '
                  '그런데 무선 통신 기술이 발달하면서 에펠탑은 전파탑으로 활용되기 시작했어요. '
                  '그 덕분에 철거 계획은 사라졌죠. 지금은 연간 수백만 명이 찾는 파리의 랜드마크로, '
                  '“처음엔 미움받았지만 결국 사랑받게 된 건축물”로 기억되고 있어요.',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontFamily: 'Pretendard',
                    letterSpacing: -0.5,
                    height: 1.6,
                  ),
                ),

                const SizedBox(height: 40),

                RecommendPlaceButton(
                  onTap: () {
                    print('추천 플레이스 버튼 클릭됨');
                    Navigator.pushNamed(context, '/recommend');
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
