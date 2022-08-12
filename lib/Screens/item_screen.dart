import 'package:flutter/material.dart';
import 'package:vibration_catcher/bloc/excel_bloc.dart';
import 'package:vibration_catcher/models/metric_model.dart';

class Records extends StatefulWidget {
  const Records({Key? key}) : super(key: key);

  @override
  State<Records> createState() => _RecordsState();
}

class _RecordsState extends State<Records> {
late Future<List<FeedbackForm>> model;
@override
  void initState() {
    super.initState();
      setState(() {
        model = SheetStorage().getFeedbackList();
      });
      } 



  @override
  Widget build(BuildContext context) {
    //SheetStorage().getSheet;
    return Container(
      child: FutureBuilder<List<FeedbackForm>>(
  future: model,
  builder: (context, snapshot) {
      if (snapshot.hasData) {
      print("geldi");
      //print(snapshot.data![0].x.toString());
      return Text(snapshot.data![0].x.toString() + "z");
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
