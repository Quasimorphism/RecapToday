import 'package:flutter/material.dart';
import 'package:test6/screens/home_screen.dart';
import 'package:test6/screens/login_screen.dart';
import 'package:test6/utils/app_theme.dart';

// 로그인 기능 활성화 여부를 결정하는 상수
// true: 로그인 화면 표시 (로그인 기능 활성화)
// false: 로그인 화면 건너뛰기 (홈 화면으로 바로 이동)
const bool useLoginFeature = true; // 로그인 기능을 활성화하기 위해 true로 변경

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recap Today',
      theme: AppTheme.themeData,
      debugShowCheckedModeBanner: true,
      initialRoute: useLoginFeature ? '/' : '/home', // 설정에 따라 초기 화면 결정
      routes: {
        '/': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}
