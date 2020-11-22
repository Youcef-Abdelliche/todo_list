import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:todo_list/models/task.dart';
import 'package:todo_list/models/task_category.dart';
import 'package:todo_list/provider/databaseProvider.dart';
import 'package:todo_list/screens/category_screens/new_category.dart';
import 'package:todo_list/screens/home/components/body.dart';

import '../../constants.dart';
import '../../size_config.dart';

class EditTaskScreen extends StatefulWidget {
  final Task task;

  const EditTaskScreen({
    Key key,
    this.task,
  }) : super(key: key);
  @override
  _EditTaskScreenState createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  double defaultSize = SizeConfig.defaultSize;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _title;
  String _description;
  TimeOfDay _time;
  String _date;
  TaskCategory _categoryTitle;
  int _categoryId;
  //Color _selectedColor;
  List<TaskCategory> listCategories = [];

  @override
  void initState() {
    super.initState();

    setState(() {
      _time = TimeOfDay(
          hour: widget.task.time ~/ 60, minute: widget.task.time % 60);
      _date = widget.task.date;
      _title = widget.task.title;
      _description  = widget.task.description;


      loadData().whenComplete(() {
        _categoryTitle = search();
        _categoryId = _categoryTitle.id;
      });
      //_categoryTitle = search();
      /*loadData().then((value) {
        
      });*/
      //_categoryTitle = list[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Edit Task")),
        body: Container(
            margin: EdgeInsets.all(defaultSize * 2),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildTitleField(),
                    SizedBox(height: SizeConfig.defaultSize * 1.4),
                    buildDescriptionField(),
                    SizedBox(height: SizeConfig.defaultSize * 1.4),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: defaultSize * 2),
                      child: Row(
                        children: [
                          Text(
                            "Due Time",
                            style: TextStyle(fontSize: defaultSize * 2),
                          ),
                          SizedBox(width: defaultSize),
                          GestureDetector(
                            onTap: () {
                              print("Pick date");
                              DatePicker.showTimePicker(context,
                                  showTitleActions: true, onChanged: (date) {
                                print('change $date');
                              }, onConfirm: (date) {
                                print('confirm $date');
                                setState(() {
                                  _time = _time.replacing(
                                      hour: date.hour, minute: date.minute);
                                });
                              },
                                  currentTime: DateTime.now(),
                                  locale: LocaleType.en);
                            },
                            child: Container(
                                padding: EdgeInsets.all(defaultSize),
                                decoration: BoxDecoration(
                                    color: Color(0xff6074F9),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Text(_time.toString().substring(10, 15),
                                    style: TextStyle(
                                        fontSize: defaultSize * 2,
                                        color: Colors.white))),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: defaultSize * 1.4),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: defaultSize * 2),
                      child: Row(
                        children: [
                          Text(
                            "Due Date",
                            style: TextStyle(fontSize: defaultSize * 2),
                          ),
                          SizedBox(width: defaultSize),
                          GestureDetector(
                            onTap: () {
                              print("Pick date");
                              DatePicker.showDatePicker(context,
                                  showTitleActions: true,
                                  minTime: DateTime(2020), onChanged: (date) {
                                print('change $date');
                              }, onConfirm: (date) {
                                print('confirm $date');
                                setState(() {
                                  _date = date.year.toString() +
                                      "-" +
                                      date.month.toString() +
                                      "-" +
                                      date.day.toString();
                                });
                              },
                                  currentTime: DateTime.now(),
                                  locale: LocaleType.en);
                            },
                            child: Container(
                                padding: EdgeInsets.all(defaultSize),
                                decoration: BoxDecoration(
                                    color: Color(0xff6074F9),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Text(_date,
                                    style: TextStyle(
                                        fontSize: defaultSize * 2,
                                        color: Colors.white))),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: SizeConfig.defaultSize * 1.4),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: defaultSize * 2),
                      child: Row(
                        children: [
                          Text(
                            "Category",
                            style: TextStyle(fontSize: defaultSize * 2),
                          ),
                          SizedBox(width: defaultSize),
                          DropdownButton(
                            value: _categoryTitle,
                            hint: Text("Select Category"),
                            items: listCategories
                                .map((TaskCategory value) =>
                                    DropdownMenuItem<TaskCategory>(
                                      value: value,
                                      child: Text(value.title,
                                          style: TextStyle(
                                              fontSize: defaultSize * 2)),
                                    ))
                                .toList(),
                            onChanged: (TaskCategory value) {
                              setState(() {
                                _categoryTitle = value;
                                _categoryId = listCategories
                                                  .where((element) =>
                                                      element.title == value.title)
                                                  .toList()[0]
                                                  .id;
                              });
                            },
                          ),
                          /*FutureBuilder(
                                    future: DBProvider.db.getAllCategories(),
                                    builder: (context, AsyncSnapshot snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Center(
                                          child: Text("Loading..."),
                                        );
                                      } else if (snapshot.hasData) {
                                        return DropdownButton(
                                          value: _categoryTitle,
                                          hint: Text("Select Category"),
                                          items: snapshot.data
                                              .map((TaskCategory value) =>
                                                  DropdownMenuItem<TaskCategory>(
                                                    value: value,
                                                    child: Text(value.title,
                                                        style: TextStyle(
                                                            fontSize:
                                                                defaultSize * 2)),
                                                  ))
                                              .toList(),
                                          onChanged: (TaskCategory value) {
                                            setState(() {
                                              _categoryTitle = value;
                                              /*_categoryId = snapshot.data
                                                  .where((element) =>
                                                      element.title == categoryItem)
                                                  .toList()[0]
                                                  .id;*/
                                            });
                                          },
                                        );
                                      } else if (snapshot.data.title == null) {
                                        return Center(
                                            child: CircularProgressIndicator());
                                      }
                                      return Center(
                                          child: CircularProgressIndicator());
                                    }),*/
                          IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                // Open an alertdialog to add a new catogory
                                /* Route route = MaterialPageRoute(
                                          builder: (context) => NewCategory());
                                      Navigator.of(context)
                                          .push(route)
                                          .then((value) => setState(() {}));*/
                              })
                        ],
                      ),
                    ),
                    SizedBox(height: SizeConfig.defaultSize * 1.4),
                    FlatButton(
                      child: Container(
                        width: SizeConfig.screenWidth,
                        decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(4)),
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: defaultSize * 1.4),
                          child: Text(
                            "Confirm",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: defaultSize * 2, color: Colors.white),
                          ),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                                int time = _time.hour * 60 + _time.minute;
                                Task task = new Task(
                                  id: widget.task.id,
                                  title: _title,
                                  date: _date,
                                  description: _description,
                                  //color: _selectedColor.value,
                                  time: time,
                                  categoryId: _categoryId,
                                );
                                print(task.title);
                                DBProvider.db.updateTask(task);
                                Navigator.of(context).pop();
                        }
                      },
                    )
                  ],
                ),
              ),
            )));
  }

  Widget buildDescriptionField() {
    OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(color: Colors.grey),
      gapPadding: 10,
    );
    return Container(
      margin: EdgeInsets.symmetric(horizontal: defaultSize * 1.8),
      child: TextFormField(
        initialValue: widget.task.description,
        keyboardType: TextInputType.name,
        maxLines: 8,
        decoration: InputDecoration(
          hintText: "Description",
          border: outlineInputBorder,
          enabledBorder: outlineInputBorder,
          focusedBorder: outlineInputBorder,
          contentPadding: EdgeInsets.symmetric(
              horizontal: SizeConfig.defaultSize * 2.2,
              vertical: SizeConfig.defaultSize * 2),
        ),
        validator: (value) {
          return null;
        },
        onSaved: (value) {
          _description = value;
        },
      ),
    );
  }

  Widget buildTitleField() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: defaultSize * 1.2),
      child: TextFormField(
        keyboardType: TextInputType.name,
        style:
            TextStyle(fontWeight: FontWeight.bold, fontSize: defaultSize * 2),
        initialValue: widget.task.title,
        decoration: InputDecoration(
          hintText: "Title",
          contentPadding: EdgeInsets.symmetric(
              horizontal: SizeConfig.defaultSize * 1.2,
              vertical: SizeConfig.defaultSize * 2),
        ),
        validator: (value) {
          return (value.trim().isEmpty) ? "Title is empty" : null;
        },
        onSaved: (value) {
          _title = value;
        },
      ),
    );
  }

  Future loadData() async {
    List<TaskCategory> list = await DBProvider.db.getAllCategories();
    setState(() {
      listCategories = list;
    });
    debugPrint("DataLoaded");
    //return list;
  }

  TaskCategory search() {
    List<TaskCategory> list = listCategories
        .where((element) => element.title == widget.task.taskCategory.title)
        .toList();
    return list[0];
  }
}

List<TaskCategory> list = [
  TaskCategory(id: 1, title: "Task1", color: Colors.red.value),
  TaskCategory(id: 2, title: "Task2", color: Colors.blue.value),
];
