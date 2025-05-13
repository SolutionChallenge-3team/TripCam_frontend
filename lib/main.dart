import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:tripcam/auth/login.dart';
import 'package:tripcam/main_wrapper.dart';

import 'firebase_options.dart';
import 'camera/camera_screen.dart';
import 'loding/loading_screen.dart';
import 'settings/logout_setting.dart';
import 'settings/settinig_list.dart';
import 'recomend/recommend_screen.dart';
import 'History/history_screen.dart';
import 'common/theme.dart';
import 'settings/nickname_setting.dart';
import 'home.dart';
import 'calendar/calendar_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase 초기화
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // 날짜 형식 로케일 초기화
  await initializeDateFormatting('ko_KR', null);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TripCam',
      debugShowCheckedModeBanner: false,
      theme: Appfonts.lightTheme,
      home: const MainWrapper(),
      routes: {
        '/nickname': (context) => const NicknameSetting(),
        '/camera': (context) => const CameraScreen(),
        '/recommend': (context) => const RecommendScreen(),
        '/history': (context) => const HistoryScreen(imageFile: null),
        '/loading': (context) => const LoadingScreen(),
      },
    );
  }
}
