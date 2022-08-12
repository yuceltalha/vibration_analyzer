import 'package:flutter/material.dart';

class SheetListPage extends StatefulWidget {
  SheetListPage({Key? key}) : super(key: key);

  @override
  State<SheetListPage> createState() => _SheetListPageState();
}

class _SheetListPageState extends State<SheetListPage> {



  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: 5,
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
