import 'package:flutter/material.dart';
import 'package:madcamp_w1/screens/color_change.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:madcamp_w1/screens/tab_3.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Color newColor=Colors.green;
  Future<Color> _loadColor() async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    int savedColorValue=prefs.getInt('savedColor') ?? Colors.green.value;
    setState(() {
      newColor=Color(savedColorValue);
    });
    return Colors.green;
  }
  @override
  void initState(){
    super.initState();
    _loadColor();
  }
  var index = 0;

  List<Widget> pages = [Text('1page'), Text('2page'), Tab3()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          'week1 project',
          style: TextStyle(color: Colors.green),
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
