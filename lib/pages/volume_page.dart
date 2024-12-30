import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VolumePage extends StatefulWidget {
  const VolumePage({Key? key}) : super(key: key);

  @override
  State<VolumePage> createState() => _VolumePageState();
}

class _VolumePageState extends State<VolumePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'volume page',
      ),
    );
  }
}
