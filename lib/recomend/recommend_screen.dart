import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../common/button.dart'; // CommonBackButton을 위해 필요

class RecommendScreen extends StatelessWidget {
  const RecommendScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: ListView(
            children: [
              // 뒤로가기 버튼 + 제목 + 홈 아이콘
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: const [
                      CommonBackButton(),
                      SizedBox(width: 12),
                      Text(
                        '에펠탑',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                          fontFamily: 'Pretendard',
                        ),
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.home_outlined,
                    size: 28,
                    color: Colors.black,
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // 위치 정보
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

              // 안내 문구
              const Text(
                '[관광지] 주변에서 즐길 수 있는 로컬 체험과 소규모 전통 가게 5곳을\n엄선해서 추천해 드릴게요. [관광지]의 진짜 매력을 느낄 수 있을 거예요!',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2449FF),
                  height: 1.6,
                  fontFamily: 'Pretendard',
                ),
              ),
              const SizedBox(height: 24),

              // 추천 카드 1
              _recommendCard(
                number: '1',
                title: 'La Droguerie du Pont de l\'Alma',
                description:
                    '오랫동안 사랑받아온 작고 아담한 잡화점이에요. 형형색색의 실타래, 단추, 레이스 등 다양한 수공예 용품을 판매하고 있어서 구경하는 재미가 쏠쏠하답니다. 프랑스 할머니들의 손맛이 느껴지는 따뜻한 공간이에요.',
              ),

              const SizedBox(height: 12),

              // 지도 연결 박스
              _mapBox(
                address: '82 Rue du Bac, 75007 Paris',
                url: 'https://maps.google.com/?q=82+Rue+du+Bac,+75007+Paris',
              ),

              const SizedBox(height: 24),

              // 추천 카드 2
              _recommendCard(
                number: '2',
                title: 'Marché Saxe-Breteuil',
                description:
                    '매주 목요일과 토요일 오전에 열리는 활기 넘치는 야외 시장이에요. 신선한 프랑스 농산물, 치즈, 빵, 꽃 등 현지인들의 삶을 엿볼 수 있는 다양한 품목을 판매합니다. 맛있는 길거리 음식도 놓치지 마세요!',
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _recommendCard({
    required String number,
    required String title,
    required String description,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$number. $title',
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 13,
            fontFamily: 'Pretendard',
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Color(0xFFD9D9D9)),
          ),
          child: Text(
            description,
            style: const TextStyle(
              fontSize: 12,
              height: 1.6,
              fontWeight: FontWeight.w500,
              fontFamily: 'Pretendard',
            ),
          ),
        ),
      ],
    );
  }

  Widget _mapBox({required String address, required String url}) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color(0xFFD9D9D9)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            address,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 12,
              fontFamily: 'Pretendard',
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '지도 열람 :\n구글 지도 열기 또는\n지도 앱에서는 링크 띄우기',
            style: TextStyle(
              fontSize: 12,
              height: 1.6,
              fontFamily: 'Pretendard',
            ),
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () => launchUrl(Uri.parse(url)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Icon(Icons.language, color: Colors.black),
                SizedBox(width: 4),
                Text(
                  'Google',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
