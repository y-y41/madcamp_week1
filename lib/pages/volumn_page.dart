import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VolumnPage extends StatefulWidget {
  const VolumnPage({Key? key}) : super(key: key);

  @override
  State<VolumnPage> createState() => _VolumnPageState();
}

class _VolumnPageState extends State<VolumnPage> {
  double _volume = 10.0;

  final List<int> _scores = [-10, -5, 5, 10, 5, -5, -10];
  final List<Offset> _tappedPoints = [];

  void _updateScore(int score) {
    setState(() {
      _volume = (_volume + score).clamp(0, 100);
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
                    painter: TargetPainter(_scores, _tappedPoints),
                  ),
                  GestureDetector(
                    onTapUp: (details) {
                      final RenderBox box =
                          context.findRenderObject() as RenderBox;
                      Offset localPosition =
                          box.globalToLocal(details.globalPosition);
                      setState(() {
                        _tappedPoints.add(localPosition);
                      });
                      int score = _getScore(localPosition);
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
    double centerX = MediaQuery.of(context).size.width / 2;
    double centerY =
        (MediaQuery.of(context).size.height - AppBar().preferredSize.height) /
            2;
    Offset center = Offset(centerX, centerY);

    double distance = (position - center).distance;
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

  TargetPainter(this.scores, this.tappedPoints);

  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..style = PaintingStyle.fill;

    for (int i = 0; i < scores.length; i++) {
      paint.color = i.isEven ? Colors.blue : Colors.red;
      double radius = size.width / 2 - (i * 40);
      canvas.drawCircle(size.center(Offset.zero), radius, paint);

      TextPainter textPainter = TextPainter(
          text: TextSpan(
            text: scores[i].toString(),
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          textDirection: TextDirection.ltr)
        ..layout();

      textPainter.paint(
        canvas,
        size.center(Offset.zero) - Offset(0, radius - 20),
      );
    }

    Paint pointPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;
    for (Offset point in tappedPoints) {
      canvas.drawCircle(point, 2, pointPaint);
    }
  }

  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
