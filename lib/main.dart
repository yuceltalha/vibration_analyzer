import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:vibration_catcher/Screens/sheet_list.dart';
import 'Screens/home_page.dart';

void main() {
  runApp(const MainPage());
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final screens = [
    HomePage(),
    SheetListPage(),
  ];
  List<Widget> items = const[
    Icon(Icons.home, size: 30),
    Icon(Icons.list, size: 30)
  ];

  int currentPage = 0;

  void changePage(int index) {
    setState(() {
      currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Define the default brightness and colors.
        // brightness: Brightness.dark,
        primaryColor: Colors.indigo,
      ),
      home: Scaffold(
        backgroundColor: Colors.indigo.shade800,
        appBar: AppBar(
          toolbarHeight: 45,
          elevation: 0,
          title: const Text("Titreşim Analizi"),
          centerTitle: true,
          backgroundColor: Colors.indigo.shade800,
         ),
        // bottomNavigationBar: CurvedNavigationBar(
        //   animationDuration: const Duration(milliseconds: 600),
        //   buttonBackgroundColor: Colors.blueAccent,
        //   backgroundColor: Colors.white,
        //   color: Colors.indigoAccent,
        //   items: items,
        //   index: currentPage,
        //   onTap: changePage,
        // ),
        body: Center(
          child: screens[currentPage],
        ),
      ),
    );
  }
}
