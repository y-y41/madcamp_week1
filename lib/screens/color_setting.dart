import 'package:flutter/material.dart';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:madcamp_w1/screens/home_screen.dart';

class RotatingBar extends StatefulWidget {
  @override
  _RotatingBarState createState() => _RotatingBarState();
}

class _RotatingBarState extends State<RotatingBar>
    with SingleTickerProviderStateMixin {
  Offset center = Offset(0, 0); // Center of the bar
  Offset initialTouchPoint = Offset(0, 0);
  double angle = 0.0; // Current angle of the bar
  double initialAngle = 0.0;
  double minAngle = -pi / 2.5;
  double maxAngle = pi / 9.5;

  bool isLoading = true;

  late AnimationController _controller;
  late Animation<double> _animation;

  List<String> imagepaths = [
    'lib/screens/pngwing.com.png',
    'lib/screens/catimage.png',
    'lib/screens/balck cat.png',
    'lib/screens/pngegg.png',
    'lib/screens/cat1.png',
    'lib/screens/cat3.png'
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.bounceOut,
    );
    _loadAngle();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void startBounceAnimation(double targetAngle) {
    _controller.reset();
    _controller.forward();
    _controller.addListener(() {
      setState(() {
        if (targetAngle < 0) {
          angle = targetAngle + _animation.value * 1.45;
        } else {
          angle = targetAngle - _animation.value * 0.65;
        }
      });
    });
    angle = 0;
  }

  Color calculate(double angle) {
    double normalizedAngle = (angle - minAngle) / (maxAngle - minAngle);
    Color newColor =
        HSVColor.fromAHSV(1.0, normalizedAngle * 360, 1.0, 1.0).toColor();
    GlobalVariables.updatecolor(newColor);
    return GlobalVariables.appBarColor;
  }

  Future<void> _loadAngle() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double savedAngle = prefs.getDouble('rotationAngle') ?? 0.0;
    setState(() {
      angle = prefs.getDouble('rotationAngle') ?? 0.0;
      isLoading = false;
    });
  }

  Future<void> _saveAngle(Color color) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('rotationAngle', angle);
    prefs.setInt('savedColor', color.value);
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    final currentColor = calculate(angle);
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.biggest;
        return GestureDetector(
          onPanStart: (details) {
            setState(() {
              center = Offset(
                size.width / 2,
                size.height / 2,
              );
              initialTouchPoint = details.localPosition;
              initialAngle = angle;
            });
          },
          onPanUpdate: (details) {
            final touchPoint = details.localPosition;

            setState(() {
              // Calculate the angle between the center and the touch point
              double relativeAngle = atan2(
                    touchPoint.dy - center.dy,
                    touchPoint.dx - center.dx,
                  ) -
                  atan2(
                    initialTouchPoint.dy - center.dy,
                    initialTouchPoint.dx - center.dx,
                  );
              angle = (initialAngle + relativeAngle).clamp(minAngle, maxAngle);
            });
          },
          onPanEnd: (details) {
            _saveAngle(GlobalVariables.appBarColor);
            if (angle == minAngle) {
              startBounceAnimation(minAngle);
            }
            if (angle == maxAngle) {
              startBounceAnimation(maxAngle);
            }
            _controller.forward();
            Future.delayed(_controller.duration!, () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            });
            // startBounceAnimation(angle);
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: 1),
            color: calculate(angle),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: 90,
                  bottom: 0,
                  left: 200,
                  child: Transform.rotate(
                    alignment: Alignment(-0.4, 0),
                    angle: angle,
                    child: Transform.scale(
                      scale: 0.15,
                      child: Image.network(
                        imagepaths[3],
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Transform.scale(
                    scale: 0.7,
                    child: Image.network(
                      (angle == minAngle || angle == maxAngle)
                          ? imagepaths[5]
                          : imagepaths[4],
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
