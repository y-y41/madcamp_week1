import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:madcamp_w1/screens/call_page.dart';
import 'package:madcamp_w1/screens/image_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:madcamp_w1/screens/tab_3.dart';
import 'dart:math';

class GlobalVariables {
  static Color appBarColor = HSVColor.fromAHSV(1.0,(pi/3.5)/(pi/8.5+pi/3.5)*360, 1.0, 1.0).toColor();
  static void updatecolor(Color newColor) async {
    appBarColor = newColor;
    await saveColor(newColor);
  }

  static Color getColor() {
    return appBarColor;
  }

  static Future<void> saveColor(Color color) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('savedColor', color.value);
  }

  static Future<void> loadColor() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int savedColorValue = prefs.getInt('savedColor') ?? HSVColor.fromAHSV(1.0,(pi/3.5)/(pi/8.5+pi/3.5)*360, 1.0, 1.0).toColor().value;
    appBarColor = Color(savedColorValue);
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Color newColor = GlobalVariables.appBarColor;
  Future<Color> _loadColor() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int savedColorValue = prefs.getInt('savedColor') ?? Colors.green.value;
    setState(() {
      newColor = Color(savedColorValue);
    });
    return GlobalVariables.appBarColor;
  }

  @override
  void initState() {
    super.initState();
    _loadColor();
  }

  var index = 0;

  List<Widget> pages = [CallPage(), imagelist(), Tab3()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: index == 2 ? Color(0xFFF5F5F5) : Colors.white,
        title: Text(
          'KAGO',
          style: TextStyle(
              color: GlobalVariables.appBarColor,
              fontSize: 24,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w800),
        ),
      ),
      body: Container(color: Colors.white, child: pages[index]),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: index,
        onTap: (value) {
          setState(() {
            index = value;
          });
        },
        selectedItemColor: GlobalVariables.appBarColor,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.paw_solid,
                // size: 30,
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.photo_fill,
                // size: 30,
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.settings_rounded,
                // size: 30,
              ),
              label: '')
        ],
      ),
    );
  }
}
