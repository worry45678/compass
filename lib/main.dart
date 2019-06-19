import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double _direction = 0;
  double _total_direction = 0;
  

  @override
  void initState() {
    super.initState();
    FlutterCompass.events.listen((double direction) {
      double step = 0;
      double diff = direction - _direction;
      if(diff >330){
        step = diff - 360;
      } else if(diff < -330){
        step = diff + 360;
      } else {
        step = diff;
      }
      _total_direction+=step;
      setState(() {
        _direction = direction;
      });
    });
  }

  

  void _totalrefresh() {
    setState(() {
      _total_direction = 0;
    });
  }



  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
          appBar: new AppBar(
            title: const Text('手机旋转圈数计算'),
          ),
          body: new ListView(children: <Widget>[
            new ListTile(
              title: new Text('当前方向'),
              subtitle: new Text('正北方向为0°'),
              trailing: new Text('${_direction.floor()}°'),
            ),
            new ListTile(
              title: new Text('累计旋转角度'),
              subtitle: new Text('已旋转${(_total_direction/360).round()}圈'),
              trailing: new Text('${_total_direction.floor()}°'),
            ),
            new Transform.rotate(
              angle: ((_direction ?? 0) * (pi / 180) * -1),
              child: new Image.asset('assets/compass.jpg'),
            ),
          ]),
          floatingActionButton: new FloatingActionButton(
              onPressed: _totalrefresh,
               child: Icon(Icons.refresh))),
    );
  }
}
