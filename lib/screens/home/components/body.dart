import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_list/constants.dart';
import 'package:todo_list/models/task.dart';
import 'package:todo_list/provider/databaseProvider.dart';
import 'package:todo_list/screens/home/components/task_widget.dart';
import 'package:todo_list/screens/task_screens/edit_task.dart';
import 'package:todo_list/size_config.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool isToday = true;

  CalendarController ctrl;

  DateTime todayDate = DateTime.now();

  List<dynamic> selectedDayTasks = [];

  List<dynamic> todayTasks = [];

  DateTime initialDay = DateTime.now();

  GlobalKey _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    ctrl = new CalendarController();
    loadData().then((value) {
      setState(() {
        selectedDayTasks = value;
        todayTasks = value;
      });
    });
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
            : FutureBuilder(
                future: DBProvider.db.getEvents(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return TableCalendar(
                      calendarController: ctrl,
                      startingDayOfWeek: StartingDayOfWeek.sunday,
                      initialCalendarFormat: CalendarFormat.twoWeeks,
                      events: snapshot.data,
                      calendarStyle: CalendarStyle(
                        markersColor: kPrimaryColor,
                        markersMaxAmount: 3,
                      ),
                      initialSelectedDay: initialDay,
                    );
                  } else if (snapshot.hasData) {
                    return TableCalendar(
                      calendarController: ctrl,
                      startingDayOfWeek: StartingDayOfWeek.sunday,
                      initialCalendarFormat: CalendarFormat.twoWeeks,
                      events: snapshot.data,
                      calendarStyle: CalendarStyle(
                        markersColor: kPrimaryColor,
                        markersMaxAmount: 3,
                      ),
                      initialSelectedDay: initialDay,
                      onDaySelected: (dateTime, list1, list2) {
                        setState(() {
                          initialDay = dateTime;
                          selectedDayTasks = list1;
                          if (dateTime == DateTime.now()) todayTasks = list1;
                        });
                      },
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
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
                            future: (isToday)
                                ? DBProvider.db.getTodayTasks()
                                : DBProvider.db.getTaskByDate(
                                    initialDay.year.toString() +
                                        "-" +
                                        initialDay.month.toString() +
                                        "-" +
                                        initialDay.day.toString()),
                            builder: (context, AsyncSnapshot snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Text("");
                              } else if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                if (snapshot.hasData) {
                                  return Column(
                                    children: List.generate(
                                        snapshot.data.length, (index) {
                                      return TaskWidget(
                                        color:
                                            Color(snapshot.data[index].color),
                                        name: snapshot.data[index].title,
                                        date: snapshot.data[index].date,
                                        category:
                                            snapshot.data[index].taskCategory,
                                        time: TimeOfDay(
                                            hour:
                                                snapshot.data[index].time ~/ 60,
                                            minute:
                                                snapshot.data[index].time % 60),
                                        function: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                    title:
                                                        Text("Delete a task"),
                                                    content: Text(
                                                        "Are you sure you want to delete this task ?"),
                                                    actions: [
                                                      FlatButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              DBProvider.db
                                                                  .deleteTask(
                                                                      snapshot
                                                                          .data[
                                                                              index]
                                                                          .id);
                                                            });
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Text("Ok")),
                                                      FlatButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Text("Cancel"))
                                                    ],
                                                  ));
                                        },
                                        function2: () {
                                          // Edit task
                                          Route route = MaterialPageRoute(
                                              builder: (context) =>
                                                  EditTaskScreen(
                                                    task: snapshot.data[index],
                                                  ));
                                          Navigator.of(context).push(route).then((value) => setState((){}));
                                        },
                                      );
                                    }),
                                  );
                                } else
                                  return Text("Error");
                              } else
                                return Text("Error");
                            })
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

Future<List<Task>> loadData() async {
  return await DBProvider.db.getTodayTasks();
}
