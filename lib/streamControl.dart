import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:async';
import 'dart:math';
import 'package:rxdart/rxdart.dart';

class MyApp3 extends StatefulWidget {
  const MyApp3({super.key});

  @override
  State<MyApp3> createState() => _MyApp3State();
}

class _MyApp3State extends State<MyApp3> {
  var diffValues = [];
  final acStreamSub = <StreamSubscription<dynamic>>[];
  var actualDiff = [];
  Timer? timer;
  late UserAccelerometerEvent eventt;

  @override
  initState() {
    super.initState();
    runAcc();
  }
  runAcc(){
    acStreamSub.add(userAccelerometerEvents.listen((UserAccelerometerEvent event) {
      setState(() {
        eventt = event;
        if (diffValues == []) {
          diffValues.add(event.y);
        } else if (diffValues.length == 1) {
          diffValues.add(event.y);
        } else if ((diffValues[-1] - diffValues[-2] > 0 &&
            diffValues[-1] - event.y < 0) ||
            (diffValues[-2] - diffValues[-1] > 0 &&
                (event.y - diffValues[-1]) < 0)) {
          diffValues.add(event.y);
        }
      });
    }));
  }
  void dispose() {
    super.dispose();
    }

  canceller(){
    for (final sub in acStreamSub) {
      sub.cancel();
    }
    }
  //Double rounding
  double roundDouble(double? value, int? places) {
    num mod = pow(10.0, places!);
    return ((value! * mod).round().toDouble() / mod);
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Welcome to Flutter'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('UserAccelerometer: ${eventt.y.toString()}'),
              RaisedButton(onPressed: runAcc(),
                child: Text("BAŞLAT"),
              ),
              RaisedButton(onPressed: canceller(),
              child: Text("İptal"))
            ],
          ),
        ),
      ),
    );
  }
}

