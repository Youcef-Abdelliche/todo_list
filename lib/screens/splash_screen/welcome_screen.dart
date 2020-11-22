import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo_list/screens/home/home.dart';

import '../../size_config.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    
    super.initState();
    Timer.periodic(Duration(seconds: 3), (Timer t) {
      Route route = MaterialPageRoute(builder: (context) => HomeScreen());
      Navigator.of(context).pushReplacement(route);
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Image.asset(
            "assets/images/todo.png",
            height: SizeConfig.defaultSize * 20,
            width: SizeConfig.defaultSize * 20,
          ),
        ),
        SizedBox(height: SizeConfig.defaultSize),
        Text("ToDo",
            style: TextStyle(
                color: Colors.black,
                fontSize: SizeConfig.defaultSize * 2.8,
                fontWeight: FontWeight.bold))
      ],
    ));
  }
}
