import 'package:flutter/material.dart';
import 'package:madcamp_w1/screens/home_screen.dart';
import 'package:madcamp_w1/screens/setting_page.dart';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:madcamp_w1/screens/tab_3.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
  double initialAngle = 0.0;
  double minAngle = -pi / 3.5;
  double maxAngle = pi / 8.5;
  double a = 0.6;
  double x = 0.0;
  double y = 0.0;

  bool isLoading=true;

  late AnimationController _controller;
  late Animation<double> _animation;

  List<String> imagepaths=[
    'lib/screens/image/pngegg.png',
    'lib/screens/image/cat1.png',
    'lib/screens/image/cat3.png',
    'lib/screens/image/angrycat2.png'
  ];

  @override
  void initState(){
    super.initState();
    _loadColor();
    _controller=AnimationController(
      vsync: this,
      duration: Duration(milliseconds:400),
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
          angle=targetAngle + _animation.value*1.25;
        }else{
          angle=targetAngle - _animation.value*0.65;
        }
      });
    });
    imagepaths[1] = imagepaths[3];
    angle = 0;
    a = 2;
    x = 2;
    y = 0.5;
  }

  Color calculate(double angle) {
    double normalizedAngle=(angle-minAngle)/(maxAngle-minAngle);
    Color newColor=HSVColor.fromAHSV(1.0,normalizedAngle*360, 0.9299, 0.7843).toColor();
    GlobalVariables.updatecolor(newColor);
    _saveAngle(newColor);
    return GlobalVariables.appBarColor;
  }

  Future<void> _loadAngle() async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    double savedAngle=prefs.getDouble('rotationAngle')?? (204.42/360)*(maxAngle-minAngle)+minAngle;
    int savedColorValue=prefs.getInt('savedColor') ?? Colors.green.value;
    setState(() {
      angle=savedAngle;
      GlobalVariables.updatecolor(Color(savedColorValue));
      isLoading=false;
    });
  }

  Future<void> _saveAngle(Color color) async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    prefs.setDouble('rotationAngle',angle);
    prefs.setInt('savedColor',color.value);
    GlobalVariables.updatecolor(color);
  }

  Future<void> _loadColor() async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    int savedColorValue=prefs.getInt('savedColor') ?? Colors.green.value;
    GlobalVariables.appBarColor=Color(savedColorValue);
  }


  @override
  Widget build(BuildContext context) {
    if(isLoading){
      return Center(child: CircularProgressIndicator());
    }
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
              angle=(initialAngle+relativeAngle).clamp(minAngle,maxAngle);
            });
          },
          onPanEnd: (details){
            _saveAngle(GlobalVariables.appBarColor);
            if(angle==minAngle){
              startBounceAnimation(minAngle);
            }
            if(angle==maxAngle){
              startBounceAnimation(maxAngle);
            }
            _controller.forward();
            Future.delayed(_controller.duration!,() {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
                  (Route<dynamic> route)=>false,
              );
            });
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: 1),
            color: calculate(angle),
            child: Center(
              child: Stack(
                clipBehavior: Clip.none,
                children:[
                  Align(
                    alignment: Alignment.center,
                    child:Transform.rotate(
                      alignment:Alignment.center,
                      angle: angle,
                      child: Transform.translate(
                        offset: Offset(150,10),
                        child: Transform.scale(
                          scale: 0.35,
                          child: Image.asset(
                            imagepaths[0],
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment(x, y),
                    child: Transform.scale(
                      scale: a,
                      child: Image.asset(
                        (angle==minAngle||angle==maxAngle)? imagepaths[2]: imagepaths[1],
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
