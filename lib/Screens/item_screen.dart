import 'package:flutter/material.dart';
import 'package:vibration_catcher/bloc/excel_bloc.dart';
import 'package:vibration_catcher/models/metric_model.dart';

class Records extends StatefulWidget {
  Records({Key? key}) : super(key: key);

  @override
  State<Records> createState() => _RecordsState();
}

class _RecordsState extends State<Records> {
late Future<MetricModel> model;
@override
  void initState() {
    super.initState();
    model = SheetStorage().getDataFromGoogleSheet();
  } 



  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<MetricModel>(
  future: model,
  builder: (context, snapshot) {
    if (snapshot.hasData) {
      print("geldi");
      return Text(snapshot.data!.x!.toString());
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
}
