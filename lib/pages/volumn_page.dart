import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VolumnPage extends StatefulWidget {
  const VolumnPage({Key? key}) : super(key: key);

  @override
  State<VolumnPage> createState() => _VolumnPageState();
}

class _VolumnPageState extends State<VolumnPage> {
  double _volume = 10.0;
  double _timeElapsed = 0;
  double _randomTargetSize = 1.0;

  final List<int> _scores = [-10, -5, 5, 10, 5, -5, -10];
  final List<Offset> _tappedPoints = [];

  void _updateScore(int score) {
    setState(() {
      _volume = (_volume + score).clamp(0, 100);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer.periodic(Duration(milliseconds: 10), (timer) {
      setState(() {
        _timeElapsed += 0.1;
      });
    });

    Timer.periodic(Duration(seconds: 2), (timer) {
      setState(() {
        _randomTargetSize = 0.5 + Random().nextDouble() * 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Volum Control'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
                child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CustomPaint(
                    size: Size(300, 300),
                    painter: TargetPainter(_scores, _tappedPoints, _timeElapsed,
                        _randomTargetSize),
                  ),
                  ..._tappedPoints.map((point) {
                    return Positioned(
                      child: Image.asset(
                        'assets/images/paw1.png',
                        width: 20,
                        height: 20,
                      ),
                      // Icon(
                      //   Icons.favorite,
                      //   size: 10,
                      //   color: Colors.lightGreen,
                      // ),
                      left: point.dx,
                      // (MediaQuery.of(context).size.width - 300) / 2,
                      top: point.dy - AppBar().preferredSize.height,
                      // (MediaQuery.of(context).size.height -
                      //         300 -
                      //         AppBar().preferredSize.height) /
                      //     2,
                    );
                  }).toList(),
                  GestureDetector(
                    onTapUp: (details) {
                      double centerX = MediaQuery.of(context).size.width / 2;
                      double centerY = (MediaQuery.of(context).size.height -
                              AppBar().preferredSize.height) /
                          2;
                      Offset center = Offset(centerX, centerY);

                      RenderBox box = context.findRenderObject() as RenderBox;
                      Offset localPosition =
                          box.globalToLocal(details.globalPosition);
                      // Offset(
                      //   (MediaQuery.of(context).size.width - 300) / 2,
                      //   (MediaQuery.of(context).size.height -
                      //           300 -
                      //           AppBar().preferredSize.height) /
                      //       2,
                      // );
                      setState(() {
                        _tappedPoints.add(localPosition);
                      });
                      int score = _getScore(details.globalPosition - center);
                      _updateScore(score);

                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('You scored $score points!')));
                    },
                  )
                ],
              ),
            )),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    'Volume: ${_volume.toInt()}%',
                    style: TextStyle(fontSize: 18),
                  ),
                  Slider(
                      value: _volume,
                      min: 0,
                      max: 100,
                      onChanged: (value) {
                        setState(() {
                          _volume = value;
                        });
                      })
                ],
              ),
            )
          ],
        ));
  }

  int _getScore(Offset position) {
    // double centerX = MediaQuery.of(context).size.width / 2;
    // double centerY =
    //     (MediaQuery.of(context).size.height - AppBar().preferredSize.height) /
    //         2;
    // Offset center = Offset(centerX, centerY);

    double distance = (position).distance;
    if (distance < 40) return _scores[3];
    if (distance < 80) return _scores[2];
    if (distance < 120) return _scores[1];
    if (distance < 160) return _scores[0];
    return 0;
  }
}

class TargetPainter extends CustomPainter {
  final List<int> scores;
  final List<Offset> tappedPoints;
  final double timeElapsed;
  final double randomTargetSize;

  TargetPainter(
      this.scores, this.tappedPoints, this.timeElapsed, this.randomTargetSize);

  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..style = PaintingStyle.fill;

    double targetSizeMulti = randomTargetSize;
    // if (targetSizeMulti < 0.3) targetSizeMulti = 0.3;

    for (int i = 0; i < scores.length; i++) {
      paint.color = (i == 0)
          ? Colors.black
          : (i == 1)
              ? Colors.blue
              : (i == 2)
                  ? Colors.red
                  : Colors.yellow;
      // paint.color = i.isEven ? Colors.blue : Colors.red;
      double radius = size.width / 2 - (i * 40) * targetSizeMulti;
      canvas.drawCircle(size.center(Offset.zero), radius, paint);

      TextPainter textPainter = TextPainter(
          text: TextSpan(
            text: scores[i].toString(),
            style: TextStyle(
                color: (i == 3) ? Colors.black : Colors.white, fontSize: 16),
          ),
          textDirection: TextDirection.ltr)
        ..layout();

      textPainter.paint(
        canvas,
        size.center(Offset.zero) - Offset(0, radius - 20),
      );
    }

    // Paint pointPaint = Paint()
    //   ..color = Colors.lightGreen
    //   ..style = PaintingStyle.fill;
    // for (Offset point in tappedPoints) {
    //   canvas.drawCircle(point, 5, pointPaint);
    // }
  }

  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
