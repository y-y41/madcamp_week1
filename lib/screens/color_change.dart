import 'package:flutter/material.dart';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Draggable Rotating Bar')),
        body: RotatingBar(),
      ),
    );
  }
}

class RotatingBar extends StatefulWidget {
  @override
  _RotatingBarState createState() => _RotatingBarState();
}

class _RotatingBarState extends State<RotatingBar> with SingleTickerProviderStateMixin {
  Offset center = Offset(0, 0); // Center of the bar
  Offset initialTouchPoint=Offset(0,0);
  double angle = 0.0; // Current angle of the bar
  double initialAngle=0.0;
  double minAngle=-2*pi/3;
  double maxAngle=2*pi/3;

  bool isLoading=true;

  late AnimationController _controller;
  late Animation<double> _animation;

  List<String> imagepaths=[
    'lib/screens/pngegg.png',
    'lib/screens/pngwing.com.png'
  ];

  @override
  void initState(){
    super.initState();
    _controller=AnimationController(
      vsync: this,
      duration: Duration(milliseconds:600),
    );
    _animation=CurvedAnimation(parent: _controller, curve: Curves.bounceOut,);
    _loadAngle();
  }

  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }

  void startBounceAnimation(double targetAngle){
    _controller.reset();
    _controller.forward();
    _controller.addListener((){
      setState(() {
        if(targetAngle<0){
          angle=targetAngle + _animation.value*3.15;
        }else{
          angle=targetAngle - _animation.value*3.15;
        }
      });
    });
    angle=0;
  }

  Color calculate(double angle) {
    double normalizedAngle=(angle-minAngle)/(maxAngle-minAngle);
    return HSVColor.fromAHSV(1.0,normalizedAngle*360, 1.0, 1.0).toColor();
  }

  Future<void> _loadAngle() async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    double savedAngle=prefs.getDouble('rotationAngle')?? 0.0;
    setState(() {
      angle=prefs.getDouble('rotationAngle')?? 0.0;
      isLoading=false;
    });
  }

  Future<void> _saveAngle(Color color) async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    prefs.setDouble('rotationAngle',angle);
    prefs.setInt('savedColor',color.value);
  }

  @override
  Widget build(BuildContext context) {
    if(isLoading){
      return Center(child: CircularProgressIndicator());
    }
    final currentColor=calculate(angle);
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.biggest;

        double normalizedAngle=(angle+pi)/(2*pi);

        return GestureDetector(
          onPanStart: (details) {
            setState(() {
              center = Offset(
                size.width / 2,
                size.height / 2,
              );
              initialTouchPoint=details.localPosition;
              initialAngle=angle;
            });
          },
          onPanUpdate: (details) {
            final touchPoint = details.localPosition;

            setState(() {
              // Calculate the angle between the center and the touch point
              double relativeAngle = atan2(
                touchPoint.dy - center.dy,
                touchPoint.dx - center.dx,
              )-atan2(
                initialTouchPoint.dy-center.dy,
                initialTouchPoint.dx-center.dx,
              );
              angle=(initialAngle+relativeAngle).clamp(minAngle, maxAngle);
            });
          },
          onPanEnd: (details){
            _saveAngle(currentColor);
            if(angle==minAngle){
              startBounceAnimation(minAngle);
            }
            if(angle==maxAngle){
              startBounceAnimation(maxAngle);
            }
            // startBounceAnimation(angle);
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: 10),
            color: calculate(angle),
            child:Center(
                child: Transform.rotate(
                  alignment: Alignment.center,
                  angle: angle,
                  child: Transform.scale(
                    scale: 0.5,
                    child: Image.network(
                    imagepaths[0],
                    fit: BoxFit.none,
                    ), // color: calculate(angle),
                  ),
                ),
            ),
          ),
        );
      },
    );
  }
}
