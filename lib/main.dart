import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/constants.dart';
import 'package:todo_list/provider/taskManager.dart';
import 'package:todo_list/screens/home/home.dart';
import 'package:todo_list/screens/progress_circular_Indicator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {}, //TaskManager(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(color: kPrimaryColor, elevation: 0),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
