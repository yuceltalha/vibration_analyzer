import 'package:flutter/material.dart';
import 'package:vibration_catcher/bloc/excel_bloc.dart';

class SheetListPage extends StatefulWidget {
  SheetListPage({Key? key}) : super(key: key);

  @override
  State<SheetListPage> createState() => _SheetListPageState();
}

class _SheetListPageState extends State<SheetListPage> {

List idList = SheetStorage().getSheetList();




  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: idList.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
                leading: const Icon(Icons.list),
                trailing: const Text(
                  "GFG",
                  style: TextStyle(color: Colors.green, fontSize: 15),
                ),
                title: Text("List item $index"));
          }),
    );
  }
}
