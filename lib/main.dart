import 'package:flutter/material.dart';
import 'package:madcamp_w1/screens/home_screen.dart';
import 'package:madcamp_w1/pages/lock_settings.dart';
import 'package:madcamp_w1/screens/lock_screen.dart';
import 'package:madcamp_w1/pages/volume_random_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GlobalVariables.loadColor();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mad Camp',
      builder: (context, child) {
        return Container(
          color: Colors.grey[200], // 앱 전체 배경색
          child: child,
        );
      },
      home: InitialScreen(),
    );
  }
}

class InitialScreen extends StatefulWidget {
  @override
  _InitialScreenState createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  bool _isPatternSet = false;

  @override
  void initState() {
    super.initState();
    _checkPatternSet();
  }

  Future<void> _checkPatternSet() async {
    final prefs = await SharedPreferences.getInstance();
    final pattern = prefs.getString('pattern');
    setState(() {
      _isPatternSet = pattern != null;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isPatternSet) {
      return HomeScreen();
    }
    return Scaffold(
      body: Container(
        color: Colors.grey[200], // 배경색 설정
        child: _isPatternSet
            ? _buildLockScreen(context)
            : _buildHomeScreen(context),
      ),
    );
  }

  Widget _buildLockScreen(BuildContext context) {
    return LockScreen(
      onUnlock: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      },
    );
  }

  Widget _buildHomeScreen(BuildContext context) {
    return HomeScreen();
  }
}
