import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _offset = <Offset>[];


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(child:GestureDetector(
        onPanDown: (details){
          setState(() {
            final renderBox = context.findRenderObject() as RenderBox;
            final localPosition = renderBox.globalToLocal(details.globalPosition);
            _offset.add(localPosition);
          });

        },
        onPanUpdate: (details){
          setState(() {
            final renderBox = context.findRenderObject() as RenderBox;
            final localPosition = renderBox.globalToLocal(details.globalPosition);
            _offset.add(localPosition);
          });
        },
        onPanEnd: (details){
          setState(() {
            _offset.add(null);
          });
        },
        child: Center(
          child: CustomPaint(
            painter: FlipBookPainter(_offset),
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.height,
                height: MediaQuery.of(context).size.width,
                color: Colors.transparent,
              ),
            ),
          ),
        ),
      ),)
    );
  }
}
 
class FlipBookPainter extends CustomPainter{

  final offsets;
  FlipBookPainter(this.offsets) : super();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
    ..color = Colors.deepPurple
    ..isAntiAlias = true

    ..strokeWidth = 6.0;

    for(var i=0 ; i<offsets.length;i++){
      if(offsets[i]!=null && offsets[i+1]!=null){
        canvas.drawLine(offsets[i], offsets[i+1], paint);
      }
      else if(offsets[i]!=null && offsets[i+1]==null) {
        canvas.drawPoints(PointMode.points, [offsets[i]], paint);
      }
      else{
        //
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
  
}
