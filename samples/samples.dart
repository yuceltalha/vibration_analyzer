/*

// ignore_for_file: unused_local_variable, avoid_print

import "dart:math";

sMehanic(List<int> liste) {
  if (liste.length > 3) {
    for (var i = 2; i < liste.length; i++) {
      if (liste[i] >= liste[i - 1] && liste[i - 1] >= liste[i - 2]) {
        liste.removeAt(i - 1);
      } else if (liste[i] < liste[i - 1] && liste[i - 1] < liste[i - 2]) {
        liste.removeAt(i - 1);
      }
    }
  }
  print(liste.length.toString());
  return liste;
}

kri(List a) {
  List b = [a.first];
  for(int i = 1; i< a.length-1;i++){
    if(a[i - 1] <= a[i] && a[i] >= a[i + 1]){
      b.add(a[i]);
    }
    else if(a[i - 1] >= a[i] && a[i] <= a[i + 1]){
      b.add(a[i]);
    }
  }
  b.add(a.last);
  return b;
}

vol2(List a){
  List b =[];
  bool inc =true;
  for(int i = 1; i< a.length-1;i++){
    if(a[i-1]<a[i] && a[i]<a[i+1]){
      if(inc){
        b.add(a[i]);
      }
     inc = false; 
    }
    else if(a[i-1]>a[i] && a[i]>a[i+1]){
      if(!inc){
        b.add(a[i]);
      }
      inc = true;
    }
    
  }
  return b;
}

vol3(List a){
  List b =[];
  bool inc =true;
  for(int i = 1; i< a.length-1;i++){
    if(a[i-1]<a[i]){
      if(a[i]<a[i+1]){
        
      }   
    }
  }
}



void main() {
  List<int> empt = [];
  for (var i = 0; i < 40; i++) {
    empt.add(Random().nextInt(10));
  }
  print(empt);
  print(kri(empt));
}

// ignore_for_file: unused_import, avoid_print, import_of_legacy_library_into_null_safe, depend_on_referenced_packages
import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:vibration_catcher/Screens/chart_ex.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:vibration_catcher/bloc/excel_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

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
            ),
          ),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: _mainColumn(),
          ),
        ),
      ),
    );
  }

  Column _mainColumn() {
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
                          style: textWColor(Colors.green),
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
                          style: textWColor(Colors.black),
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
                          style: textWColor(Colors.indigo),
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

            /* Timer.periodic(const Duration(seconds: 1), (timer) {
              count.add(eve.x);
              print(count.length);
              timer.cancel();
            });
            print(count.toString() + " asdgkskadlgasdl");
              count = []; */

            var valX = roundDouble(event!.x, 3);
            var valY = roundDouble(event!.y, 3);
            var valZ = roundDouble(event!.z, 3);

            sheetX.add(event!.x);
            sheetY.add(event!.y);
            sheetZ.add(event!.z);

            /* if (sheetX.length > 100) {
              SheetStorage().sheetFunc(sheetX, [], [],count);
              sheetX = [];
              count +=count;
            }
            sheetY.add(valY);
            if (sheetY.length > 100) {
              SheetStorage().sheetFunc([], sheetY, [],count);
              sheetY = [];
            }
            sheetZ.add(valZ);
            if (sheetZ.length > 100) {
              SheetStorage().sheetFunc([], [], sheetZ,count);
              sheetZ = [];
            } */
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
    fallinAPart(sheetX,1);
    fallinAPart(sheetY,2);
    fallinAPart(sheetZ,3);
    
  }

  fallinAPart(List<double> a,int line) {
    List<List<double>> x = [];

    for (int i = 0; i < a.length / 100; i++) {
      x.add([]);
    }

    for (int i = 1; i < a.length - 1; i++) {
      x[i ~/ 100].add(a[i]);
    }
    
    for (int i = 0; i < x.length; i++) {
      switch (line) {
        case 1:
          SheetStorage().sheetFunc(x[i], i, 1);
          break;
        case 2:
          SheetStorage().sheetFuncY(x[i], i, 2);
          break;
        case 3:
          SheetStorage().sheetFuncZ(x[i], i, 3);
          break;
        default:
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
}


*/ 