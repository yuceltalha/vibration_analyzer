// ignore_for_file: avoid_print, import_of_legacy_library_into_null_safe, depend_on_referenced_packages
import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:vibration_catcher/Screens/chart_ex.dart';
import 'package:vibration_catcher/Screens/item_screen.dart';
import 'package:vibration_catcher/bloc/excel_bloc.dart';
import "package:curved_navigation_bar/curved_navigation_bar.dart";

import '../models/metric_model.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  textWColor(Color colorr) {
    var axisStyle = TextStyle(
        fontFamily: "Ibarra",
        fontWeight: FontWeight.bold,
        fontSize: 18,
        color: colorr);
    return axisStyle;
  }

  late Future<List<FeedbackForm>> model;
  @override
  void initState() {
    super.initState();
    setState(() {
      model = SheetStorage().getFeedbackList();
    });
  }

  bool recording = false;
  StreamSubscription? streamSub;
  UserAccelerometerEvent? event;
  List<double> listeY = [0];
  List<double> listeX = [0];
  List<double> listeZ = [0];
  List<double> sheetX = [0];
  List<double> sheetY = [0];
  List<double> sheetZ = [0];
  String recordStat = "Start Recording";
  Color buttonColor = Colors.green;

  List<Widget> items = const <Widget>[
    Icon(
      Icons.home,
      size: 30,
    ),
    Icon(
      Icons.list,
      size: 30,
    ),
    Icon(
      Icons.person,
      size: 30,
    )
  ];
  int? index;

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
      bottomNavigationBar: CurvedNavigationBar(
        animationDuration: const Duration(milliseconds: 200),
        buttonBackgroundColor: Colors.blueAccent,
        backgroundColor: Colors.white,
        color: Colors.indigoAccent,
        items: items,
        index: 0,
        onTap: (index) {
          this.index = index;
        },
      ),
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child:Page2(),
          ),
        ),
      ),
    );
  }

  Page2() {
    return Center(
      child: FutureBuilder<List<FeedbackForm>>(
        future: model,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print("geldi");
            //print(snapshot.data![0].x.toString());
            return Text(snapshot.data![2].x.toString());
          } else if (snapshot.hasError) {
            print("gelmedi");
            return Text('${snapshot.error}');
          }

          // By default, show a loading spinner.
          return const CircularProgressIndicator();
        },
      ),
    );
  }

  _mainColumn() {
    return Column(
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
            border: Border.all(color: Colors.indigoAccent.shade200, width: 3),
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
                    style: textWColor(Colors.green),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(event?.x.toStringAsFixed(3) ?? "Değer Yok"),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    "Y",
                    style: textWColor(Colors.black),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(event?.y.toStringAsFixed(3) ?? "Değer Yok"),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    "Z",
                    style: textWColor(Colors.indigo),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(event?.z.toStringAsFixed(3) ?? "Değer Yok"),
                  ),
                  // Renders line chart
                ],
              ),
            ],
          ),
        ),

        const Divider(),

        LineChartSample4(mDataY: listeY, mDataX: listeX, mDataZ: listeZ),

        //Record Button

        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(buttonColor),
          ),
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
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              SheetStorage().clearSheet();
            });
          },
          child: const Text("Clear Table"),
        )
      ],
    );
  }

  @override
  void dispose() {
    streamSub?.cancel();
    super.dispose();
  }

  start() {
    debugPrint("recordingkkkkkk");
    streamSub = userAccelerometerEvents.listen(
      (UserAccelerometerEvent eve) {
        setState(
          () {
            buttonColor = Colors.red;
            event = eve;

            var valX = roundDouble(event!.x, 3);
            var valY = roundDouble(event!.y, 3);
            var valZ = roundDouble(event!.z, 3);

            sheetX.add(event!.x);
            sheetY.add(event!.y);
            sheetZ.add(event!.z);

            listeX.add(valX);
            listeY.add(valY);
            listeZ.add(valZ);

            if (listeX.length > 100) {
              listeX.removeAt(0);
            }

            if (listeY.length > 100) {
              listeY.removeAt(0);
            }

            if (listeZ.length > 100) {
              listeZ.removeAt(0);
            }
          },
        );
      },
    );
    recording = !recording;

    setState(
      () {
        recordStat = "Stop Recording";
      },
    );
  }

  stop() {
    buttonColor = Colors.green;
    debugPrint("Record Stopped");

    setState(
      () {
        recordStat = "Start Recording";
      },
    );
    streamSub?.cancel();
    streamSub = null;
    event = null;
    recording = !recording;
    listeX = [0];
    listeY = [0];
    listeZ = [0];
    DateTime now = DateTime.now();
    DateTime time = DateTime(now.year,now.month,now.day,now.hour,now.minute,now.second);
    print(time.toString());
    SheetStorage().createSheet(time.toString());


    uploadSheet([sheetX,sheetY,sheetZ],time.toString());
  }

  uploadSheet(List<List<double>> sheetList,String sheet) {
    
    List<List<List<double>>> x = [[], [], []];

    for (int j = 0; j < 3; j++) {
      for (int i = 0; i < sheetList[j].length / 100; i++) {
        x[j].add([]);
      }

      for (int i = 1; i < sheetList[j].length - 1; i++) {
        x[j][i ~/ 100].add(sheetList[j][i]);
      }
    }
    
    for (int i = 0; i < x.length; i++) {
      for (int j = 0; j < x[i].length; j++) {
        SheetStorage().sheetFunc(i+1,x[i][j],j,sheet);
      }
    }
  }
}

double roundDouble(num value, int power) {
  value = value * 1000;
  value = value.toInt();
  return (value.toDouble() / 1000);
}

double roundDouble2(double value, int places) {
  num mod = pow(10.0, places);
  return ((value * mod).round().toDouble() / mod);
}

peaks(List<double> a) {
  List<double> b = [a.first];

  for (int i = 1; i < a.length - 1; i++) {
    if (a[i - 1] < a[i] && a[i] > a[i + 1]) {
      b.add(a[i]);
    } else if (a[i - 1] > a[i] && a[i] < a[i + 1]) {
      b.add(a[i]);
    }
  }
  b.add(a.last);
  return b;
}
