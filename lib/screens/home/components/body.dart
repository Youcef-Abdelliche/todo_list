import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_list/constants.dart';

import 'package:todo_list/provider/databaseProvider.dart';
import 'package:todo_list/screens/home/components/task_widget.dart';
import 'package:todo_list/size_config.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool isToday = true;

  CalendarController ctrl;
  
  DateTime todayDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    ctrl = new CalendarController();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(color: kPrimaryColor),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  if (!isToday)
                    setState(() {
                      isToday = !isToday;
                    });
                },
                child: (isToday)
                    ? buildColumn("Today")
                    : Text(
                        "Today",
                        style: TextStyle(
                            color: Colors.white54,
                            fontSize: SizeConfig.defaultSize * 2),
                      ),
              ),
              SizedBox(width: SizeConfig.defaultSize * 0.5),
              GestureDetector(
                onTap: () {
                  if (isToday)
                    setState(() {
                      isToday = !isToday;
                    });
                },
                child: (isToday)
                    ? Text(
                        "Monthly",
                        style: TextStyle(
                            color: Colors.white54,
                            fontSize: SizeConfig.defaultSize * 2),
                      )
                    : buildColumn("Monthly"),
              ),
            ],
          ),
        ),
        (isToday)
            // filter is Today
            ? Container()
            /*Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.defaultSize * 0.5,
                    vertical: SizeConfig.defaultSize * 2),
              )*/
            // filter is monthly
            : TableCalendar(
                calendarController: ctrl,
                startingDayOfWeek: StartingDayOfWeek.sunday,
                initialCalendarFormat: CalendarFormat.month,
              ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: SizeConfig.defaultSize * 0.5),
                Container(
                  child: Padding(
                    padding: EdgeInsets.all(SizeConfig.defaultSize * 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Today, ${months[todayDate.month - 1]} ${todayDate.day.toString()}/${todayDate.year.toString()}",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: SizeConfig.defaultSize * 1.8),
                        ),
                        SizedBox(
                          height: SizeConfig.defaultSize,
                        ),
                        FutureBuilder(
                            future: (!isToday) ? DBProvider.db.getAllTasks() : DBProvider.db.getTodayTasks(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: Text("Loading..."),
                                );
                              } else if (snapshot.hasData) {
                                return Column(
                                  children: List.generate(snapshot.data.length,
                                      (index) {
                                    return TaskWidget(
                                      color: Color(snapshot.data[index].color),
                                      name: snapshot.data[index].title,
                                      date: snapshot.data[index].date,
                                      time: TimeOfDay(
                                          hour: snapshot.data[index].time ~/ 60,
                                          minute:
                                              snapshot.data[index].time % 60),
                                      function: () {
                                        setState(() {
                                          DBProvider.db.deleteTask(
                                              snapshot.data[index].id);
                                        });
                                      },
                                      function2: () {
                                        // Edit task
                                      },
                                    );
                                  }),
                                );
                              } else if (snapshot.data.title == null) {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                              return Center(child: CircularProgressIndicator());
                            }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Column buildColumn(String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: SizeConfig.defaultSize * 2),
          child: Text(
            text,
            style: TextStyle(
                color: Colors.white, fontSize: SizeConfig.defaultSize * 2),
          ),
        ),
        Container(
          decoration: BoxDecoration(color: Colors.white),
          width: SizeConfig.defaultSize * 10,
          height: SizeConfig.defaultSize * 0.3,
        )
      ],
    );
  }
}
