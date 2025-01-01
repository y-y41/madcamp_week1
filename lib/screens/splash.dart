import 'dart:async';
import 'package:flutter/material.dart';
import 'package:madcamp_w1/main.dart';
import 'package:madcamp_w1/screens/home_screen.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // 3초 후 메인 화면으로 이동
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => InitialScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // 이미지 영역 (Column으로 구성)
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 4, // 이미지 영역 비율 설정
                child: Center(
                  child: Image.asset(
                    'assets/images/splash_logo.png',
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.7, // 화면 너비의 70%
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.4, // 화면 높이의 40%
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
          // 문구 영역 (Positioned로 자유 배치)
          Positioned(
            bottom: MediaQuery
                .of(context)
                .size
                .height * 0.15, // 화면 높이의 25% 위치
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min, // 필요한 만큼만 공간 차지
              children: [
                Text(
                  "KAGO",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 25.0,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10), // 문구와 로딩바 간격
                CircularProgressIndicator(
                  color: Colors.blue,
                  strokeWidth: 3.0, // 로딩바 두께
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}