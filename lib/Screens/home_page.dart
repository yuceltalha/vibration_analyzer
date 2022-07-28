// ignore_for_file: unused_import, avoid_print

import 'dart:async';
import 'dart:math';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:vibration_catcher/Screens/chart_ex.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var axisStyle = const TextStyle(
      fontFamily: "Ibarra", fontWeight: FontWeight.bold, fontSize: 18);
  bool recording = false;
  StreamSubscription? streamSub;
  UserAccelerometerEvent? event;
  List<double> listeY = [0];
  List<double> listeX = [0];
  List<double> listeZ = [0];
  String recordStat = "Start Recording";
  var listLen = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.shade800,
      appBar: AppBar(
        toolbarHeight: 45,
        elevation: 0,
        title: const Text("Vibration Analyzer"),
        centerTitle: true,
        backgroundColor: Colors.indigo.shade800,
      ),
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              )),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    "Axis Values",
                    style: TextStyle(
                      fontStyle: FontStyle.normal,
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 12, left: 3, right: 3),
                  padding: const EdgeInsets.only(bottom: 12.0, top: 8),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.indigoAccent.shade200, width: 3),
                    borderRadius: BorderRadius.circular(5),
                  ),

                  //Axis Values

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            "X",
                            style: axisStyle,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                                event?.x.toStringAsFixed(3) ?? "Değer Yok"),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "Y",
                            style: axisStyle,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                                event?.y.toStringAsFixed(3) ?? "Değer Yok"),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "Z",
                            style: axisStyle,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                                event?.z.toStringAsFixed(3) ?? "Değer Yok"),
                          ),
                          // Renders line chart
                        ],
                      ),
                    ],
                  ),
                ),

                const Divider(),

                LineChartSample4(
                    mDataY: listeY, mDataX: listeX, mDataZ: listeZ),

                //Record Button

                ElevatedButton(
                  style: colorFul(Colors.red, Colors.green),
                  onPressed: () {
                    setState(
                      () {
                        if (!recording) {
                          start();
                        } else {
                          stop();
                          listeY = peaks(listeY);
                          listeX = peaks(listeX);
                          print(peaks(listeX));
                          listeZ = peaks(listeZ);
                        }
                      },
                    );
                  },
                  child: Text(recordStat),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    streamSub?.cancel();
    super.dispose();
  }

  start() {
    debugPrint("recording");
    streamSub = userAccelerometerEvents.listen((UserAccelerometerEvent eve) {
      setState(() {
        event = eve;
        var valY = roundDouble(event!.y);
        var valX = roundDouble(event!.x);
        var valZ = roundDouble(event!.z);

        listeY.add(valY);
        listeX.add(valX);
        listeX.add(valZ);
        for (int i = 0; i < listeY.length; i++) {
          if (listeY.length < 100) {
            break;
          } else {
            listeY.removeAt(0);
          }
        }

        
        for (int i = 0; i < listeX.length; i++) {
          if (listeX.length < 100) {
            break;
          } else {
            listeX.removeAt(0);
          }
        }

        

        for (int i = 0; i < listeZ.length; i++) {
          if (listeZ.length < 100) {
            break;
          } else {
            listeZ.removeAt(0);
          }
        }
      });
    });
    recording = !recording;

    setState(() {
      recordStat = "Stop Recording";
    });
  }

  double roundDouble(double value) {
    value = value - value % 0.001;
    return value;
  }

  double roundDouble2(double value, int places) {
    num mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  stop() {
    debugPrint("Record Stopped");

    setState(() {
      recordStat = "Start Recording";
    });
    streamSub?.cancel();
    streamSub = null;
    event = null;
    recording = !recording;
  }

  peaks(List<double> a) {
    List<double> b = [a.first];
    for (int i = 1; i < a.length - 1; i++) {
      if ((a[i + 1] - a[i]).abs() > 0.1) {
        if (a[i - 1] < a[i] && a[i] > a[i + 1]) {
          b.add(a[i]);
        } else if (a[i - 1] > a[i] && a[i] < a[i + 1]) {
          b.add(a[i]);
        }
      }
    }
    b.add(a.last);
    return b;
  }

  colorFul(Color color1, Color color2) {
    var buttonStyle = ButtonStyle(
        backgroundColor: recording
            ? MaterialStateProperty.all(color1)
            : MaterialStateProperty.all(color2));
    return buttonStyle;
  }
}
