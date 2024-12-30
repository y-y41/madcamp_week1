import 'package:flutter/material.dart';
import 'package:madcamp_w1/pages/font_size_page.dart';
import 'package:madcamp_w1/pages/volume_random_page.dart';
import 'package:madcamp_w1/screens/color_setting.dart';

class Tab3 extends StatelessWidget {
  const Tab3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: Text('Volume'),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => VolumeRandomPage()));
          },
        ),
        Divider(),
        ListTile(
          title: Text('Color'),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => RotatingBar()));
          },
        ),
        Divider(),
        ListTile(
          title: Text('Font size'),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => FontSizePage()));
          },
        )
      ],
    );
  }
}
