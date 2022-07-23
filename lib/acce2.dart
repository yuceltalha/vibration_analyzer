import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:async';
import 'dart:math';
import 'package:rxdart/rxdart.dart';

class MyApp2 extends StatefulWidget {
  const MyApp2({super.key});

  @override
  State<MyApp2> createState() => _MyApp2State();
}

class _MyApp2State extends State<MyApp2> {
  List<double>? _userAccelerometerValues;
  final _streamSubscriptions = <StreamSubscription<dynamic>>[];
  Timer? timer;
  double? eventY;

  //Double rounding
  double roundDouble(double value, int places) {
    num mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  @override
  Widget build(BuildContext context) {
    var userAccelerometer = _userAccelerometerValues
        ?.map((double v) => v.toStringAsFixed(1))
        .toList();

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
              Text('UserAccelerometer: ${0}'),
              FloatingActionButton(
                  child: Icon(Icons.start), onPressed: startTimer()),
            ],
          ),
        ),
      ),
    );
  }

  startTimer() {}

  List<double>? AcData;
  startListen(UserAccelerometerEvent event) {
    AcData!.add(event.x);
  }

  @override
  void dispose() {
    super.dispose();
    for (final subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }

  void initState() {
    super.initState();
    _streamSubscriptions.add(
      userAccelerometerEvents.listen(
        (UserAccelerometerEvent event) {
          setState(() {
            eventY = roundDouble(event.y, 2);
            _userAccelerometerValues = <double>[event.x, event.y, event.z];
            // startListen(event);
          });
          /* timer = Timer.periodic(const Duration(seconds: 1), (_) {
            debugPrint(_userAccelerometerValues.toString());
          }); */
        },
      ),
    );
  }
}
