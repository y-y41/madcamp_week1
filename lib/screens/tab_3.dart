import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:madcamp_w1/pages/volume_random_page.dart';
import 'package:madcamp_w1/pages/color_setting.dart';
import '../pages/lock_settings.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Tab3 extends StatelessWidget {
  const Tab3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFF5F5F5),
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        children: [
          customCard(context,
              title: '패턴설정',
              subtitle: '패턴암호를 설정해 보세요',
              imagePath: 'assets/images/set_pattern.svg', onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => LockSettings()));
          }),
          customCard(context,
              title: '볼륨조절',
              subtitle: '볼륨 크기를 조절해보세요',
              imagePath: 'assets/images/set_volume.svg', onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => VolumeRandomPage()));
          }),
          customCard(context,
              title: '색상설정',
              subtitle: '테마 색상을 설정해보세요',
              imagePath: 'assets/images/set_palette.svg', onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => RotatingBar()));
          })
        ],
      ),
    );
  }

  Widget customCard(BuildContext context,
      {required String title,
      required String subtitle,
      required String imagePath,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 180,
        margin: EdgeInsets.only(bottom: 16),
        padding: EdgeInsets.all(30),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w400),
                )
              ],
            ),
            Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SvgPicture.asset(
                  imagePath,
                  width: 110,
                  height: 110,
                  color: Color(0xFF0E87C8),
                  // fit: BoxFit.cover,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
