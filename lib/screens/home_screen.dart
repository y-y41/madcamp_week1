import 'package:flutter/material.dart';
import 'package:madcamp_w1/screens/color_setting.dart';

class GlobalVariables{
  static Color appBarColor=Colors.green;
  static void updatecolor(Color newColor){
    appBarColor=newColor;
  }
}
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var index = 0;

  List<Widget> pages = [Text('1page'), Text('2page'), RotatingBar()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalVariables.appBarColor,
        title: Text(
          'week1 project',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        // shape: Border(bottom: BorderSide(color: Colors.grey, width: 1)),
      ),
      body: pages[index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (value) {
          setState(() {
            index = value;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.call), label: 'call'),
          BottomNavigationBarItem(icon: Icon(Icons.image), label: 'image'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'setting')
        ],
      ),
    );
  }
}
