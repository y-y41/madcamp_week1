import 'package:flutter/material.dart';
import 'package:madcamp_w1/screens/call_page.dart';
import 'package:madcamp_w1/screens/image_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:madcamp_w1/screens/tab_3.dart';

class GlobalVariables {
  static Color appBarColor = Colors.green;
  static void updatecolor(Color newColor) {
    appBarColor = newColor;
  }
}
class AddressList extends StatefulWidget {
  const AddressList({Key? key}) : super(key: key);

  @override
  State<AddressList> createState() => _AddressListState();
}

class _AddressListState extends State<AddressList> {
  Color newColor = Colors.green;
  Future<Color> _loadColor() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int savedColorValue = prefs.getInt('savedColor') ?? Colors.green.value;
    setState(() {
      newColor = Color(savedColorValue);
    });
    return Colors.green;
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
        backgroundColor: Colors.green,
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
