import 'package:flutter/material.dart';

class ColorPage extends StatefulWidget {
  const ColorPage({Key? key}) : super(key: key);

  @override
  State<ColorPage> createState() => _ColorPageState();
}

class _ColorPageState extends State<ColorPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'color page',
      ),
    );
  }
}
