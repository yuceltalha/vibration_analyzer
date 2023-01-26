import 'package:flutter/material.dart';

class MonthModel {
  String playerName = "defName";
  String description = "defDesc";

  MonthModel({required playerName, required description});
}

class SheetListPage extends StatefulWidget {
  const SheetListPage({Key? key}) : super(key: key);

  @override
  State<SheetListPage> createState() => _SheetListPageState();
}
 
class _SheetListPageState extends State<SheetListPage> {

List<MonthModel> monthModel = [
      MonthModel(playerName: "talha", description: "yucel"),
      MonthModel(playerName: "name2", description: "desc2")
    ];

  @override
  Widget build(BuildContext context) {
   
    print(monthModel[0].playerName);
    return Container(
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
        child: _listBuilder(),
      ),
    );
  }

  _listBuilder() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: monthModel.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildPlayerModelList(monthModel[index]);
      },
    );
  }

  Widget _buildPlayerModelList(MonthModel items) {
    return Card(
      child: ExpansionTile(
        title: Text(
          items.playerName,
          style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
        ),
        children: <Widget>[
          ListTile(
            title: Text(
              items.description,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          )
        ],
      ),
    );
  }
}
