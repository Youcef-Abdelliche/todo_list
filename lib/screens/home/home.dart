import 'package:flutter/material.dart';
import 'package:todo_list/constants.dart';
import 'package:todo_list/screens/home/components/body.dart';
import 'package:todo_list/screens/home/components/categories_stat.dart';
import 'package:todo_list/screens/task_screens/new_Task.dart';
import 'package:todo_list/size_config.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Work List", style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
              icon: Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
              onPressed: () {
                Route route = MaterialPageRoute(builder: (context) => CategoriesStatistics());
                Navigator.of(context).push(route);
              })
        ],
      ),
      body: Body(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.of(context)
              .push((MaterialPageRoute(builder: (context) => NewTask())))
              .then((value) => {setState(() {})});
        },
      ),
    );
  }
}
