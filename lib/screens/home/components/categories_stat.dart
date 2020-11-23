import 'package:flutter/material.dart';
import 'package:todo_list/models/task_category.dart';
import 'package:todo_list/provider/databaseProvider.dart';
import 'package:todo_list/screens/test.dart';
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
        body: FutureBuilder(
            future: DBProvider.db.getTasksByCategory(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: Text("Loading..."));
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.defaultSize,
                        vertical: SizeConfig.defaultSize * 0.5),
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          print("Snapapapa: " + snapshot.data[index].itemsFinished.toString());
                          return Container(
                            decoration:
                                BoxDecoration(color: Colors.white, boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  offset: Offset(0, 9),
                                  blurRadius: 20,
                                  spreadRadius: 1)
                            ]),
                            margin: EdgeInsets.symmetric(
                                vertical: SizeConfig.defaultSize * 0.5),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color:
                                            Color(snapshot.data[index].color),
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(6),
                                            bottomLeft: Radius.circular(6))),
                                    /*margin: EdgeInsets.symmetric(
                                        horizontal: SizeConfig.defaultSize,
                                        vertical: SizeConfig.defaultSize * 0.5),*/
                                    /*padding: EdgeInsets.all(
                                        SizeConfig.defaultSize * 4),*/
                                    height: SizeConfig.defaultSize * 14,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(snapshot.data[index].title,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize:
                                                    SizeConfig.defaultSize *
                                                        2.5)),
                                        SizedBox(
                                            height:
                                                SizeConfig.defaultSize * 0.5),
                                        Text(
                                            "${snapshot.data[index].items} Tasks",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize:
                                                    SizeConfig.defaultSize * 1.5)),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    /*padding: EdgeInsets.all(
                                        SizeConfig.defaultSize),*/
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(6),
                                            bottomRight: Radius.circular(6))),
                                    child: ProgressCircularIndicator(
                                        taskCategory: snapshot.data[index]),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                  );
                } else
                  return Center(child: Text("Error!"));
              } else
                return Center(child: Text("Error!"));
            })
        /*ListView.builder(
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
          }),*/
        );
  }
}

List<TaskCategory> list = [
  TaskCategory(id: 1, color: Colors.red.value, title: "Task 1"),
  TaskCategory(id: 1, color: Colors.blue.value, title: "Task 2"),
  TaskCategory(id: 1, color: Colors.blue.value, title: "Task 2")
];
