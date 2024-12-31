import 'package:flutter/material.dart';
import 'package:madcamp_w1/screens/address_list.dart';
import 'package:madcamp_w1/screens/lock_settings.dart';
import 'package:madcamp_w1/screens/lock_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
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
    // 패턴이 설정되지 않은 경우 바로 AddressList 화면으로 이동
    if (!_isPatternSet) {
      return AddressList();
    }

    // 패턴이 설정되어 있으면 잠금 화면으로 이동
    return LockScreen(
      onUnlock: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => AddressList()),
        );
      },
    );
  }
}

