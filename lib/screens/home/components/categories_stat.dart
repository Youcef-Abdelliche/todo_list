import 'package:flutter/material.dart';
import 'package:todo_list/models/task_category.dart';
import 'package:todo_list/provider/databaseProvider.dart';
import 'package:todo_list/screens/profile_screen/components/category_box.dart';
import 'package:todo_list/screens/profile_screen/components/user_stat_card.dart';
import 'package:todo_list/screens/progress_circular_Indicator.dart';
import 'package:todo_list/size_config.dart';

class CategoriesStatistics extends StatefulWidget {
  @override
  _CategoriesStatisticsState createState() => _CategoriesStatisticsState();
}

class _CategoriesStatisticsState extends State<CategoriesStatistics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Profile")),
        body: Padding(
          padding: EdgeInsets.only(top: SizeConfig.defaultSize * 2),
          child: FutureBuilder(
              future: DBProvider.db.getTasksByCategory(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: Text("Loading..."));
                } else if (snapshot.connectionState == ConnectionState.done)
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      UserStatCard(),
                      SizedBox(height: SizeConfig.defaultSize * 2),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: SizeConfig.defaultSize * 2,
                            right: SizeConfig.defaultSize,
                          ),
                          child: Row(
                            children: List.generate(
                                snapshot.data.length,
                                (index) => CategoryBox(
                                      title: snapshot.data[index].title,
                                      items: snapshot.data[index].items,
                                      color: Color(snapshot.data[index].color),
                                    )),
                          ),
                        ),
                      ),
                      SizedBox(height: SizeConfig.defaultSize * 2),
                      Container(
                        width: SizeConfig.screenHeight,
                        margin: EdgeInsets.symmetric(
                          horizontal: SizeConfig.defaultSize * 2,
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: SizeConfig.defaultSize * 3,
                            horizontal: SizeConfig.defaultSize * 3),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                offset: Offset(0, 9),
                                blurRadius: 20,
                                spreadRadius: 1)
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Statistic",
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(height: SizeConfig.defaultSize * 2),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                  children: List.generate(
                                snapshot.data.length,
                                (index) => Container(
                                  margin: EdgeInsets.only(
                                      right: SizeConfig.defaultSize * 2),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ProgressCircularIndicator(
                                          taskCategory: snapshot.data[index],
                                        ),
                                        SizedBox(
                                            height: SizeConfig.defaultSize * 2),
                                        Text(snapshot.data[index].title)
                                      ]),
                                ),
                              )),
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                else
                  return Center(child: Text("Error!"));
              }),
        ));
  }
}
