import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

void main() {
  runApp(const HomePage());
}

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
  String recordStat = "Start Recording";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Define the default brightness and colors.
        // brightness: Brightness.dark,
        primaryColor: Colors.green,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Vibration Analyzer"),
          centerTitle: true,
          backgroundColor: Colors.green,
        ),
        body: Center(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
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
                  border: Border.all(color: Colors.green.shade200, width: 3),
                  borderRadius: BorderRadius.circular(5),
                ),
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
                          child:
                              Text(event?.x.toStringAsFixed(3) ?? "Değer Yok"),
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
                          child:
                              Text(event?.y.toStringAsFixed(3) ?? "Değer Yok"),
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
                          child:
                              Text(event?.z.toStringAsFixed(3) ?? "Değer Yok"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(height: 200),
              ElevatedButton(
                style: colorFul(Colors.red, Colors.green),
                onPressed: () {
                  setState(
                    () {
                      if (!recording) {
                        start();
                      } else {
                        stop();
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
    );
  }

  @override
  void dispose() {
    streamSub?.cancel();
    super.dispose();
  }

  start() {
    print("recording");
    streamSub = userAccelerometerEvents.listen((UserAccelerometerEvent eve) {
      setState(() {
        event = eve;
      });
    });
    recording = !recording;

    setState(() {
      recordStat = "Stop Recording";
    });
  }

  stop() {
    print("Record Stopped");

    setState(() {
      recordStat = "Start Recording";
    });
    streamSub?.cancel();
    streamSub = null;
    event = null;
    recording = !recording;
  }

  colorFul(Color color1, Color color2) {
    var buttonStyle = ButtonStyle(
        backgroundColor: recording
            ? MaterialStateProperty.all(color1)
            : MaterialStateProperty.all(color2));
    return buttonStyle;
  }
}
