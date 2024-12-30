import 'package:flutter/material.dart';

class FontSizePage extends StatefulWidget {
  const FontSizePage({Key? key}) : super(key: key);

  @override
  State<FontSizePage> createState() => _FontSizePageState();
}

class _FontSizePageState extends State<FontSizePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'font size page',
      ),
    );
  }
}
