import 'package:flutter/material.dart';
import 'package:todo_list/models/task_category.dart';
import 'package:todo_list/size_config.dart';

class CategoriesStatistics extends StatefulWidget {
  @override
  _CategoriesStatisticsState createState() => _CategoriesStatisticsState();
}

class _CategoriesStatisticsState extends State<CategoriesStatistics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Statistics")),
      body: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: list.length,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                  color: Color(list[index].color),
                  borderRadius: BorderRadius.circular(6)),
              margin: EdgeInsets.symmetric(
                  horizontal: SizeConfig.defaultSize,
                  vertical: SizeConfig.defaultSize * 0.5),
              padding: EdgeInsets.all(SizeConfig.defaultSize * 0.5),
              height: SizeConfig.defaultSize * 14,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(list[index].title,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: SizeConfig.defaultSize * 2)),
                  SizedBox(height: SizeConfig.defaultSize * 0.5),
                  Text("12 Tasks",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: SizeConfig.defaultSize)),
                 
                ],
              ),
            );
          }),
    );
  }
}

List<TaskCategory> list = [
  TaskCategory(id: 1, color: Colors.red.value, title: "Task 1"),
  TaskCategory(id: 1, color: Colors.blue.value, title: "Task 2"),
  TaskCategory(id: 1, color: Colors.blue.value, title: "Task 2")
];
