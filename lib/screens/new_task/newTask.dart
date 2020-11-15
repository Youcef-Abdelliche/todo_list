import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:todo_list/constants.dart';
import 'package:todo_list/models/task.dart';
import 'package:todo_list/models/task_category.dart';
import 'package:todo_list/provider/databaseProvider.dart';
import 'package:todo_list/screens/category_screens/new_category.dart';
import 'package:todo_list/size_config.dart';

class NewTask extends StatefulWidget {
  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  double defaultSize = SizeConfig.defaultSize;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _title;
  String _description;
  TimeOfDay _time =
      TimeOfDay(hour: TimeOfDay.now().hour, minute: TimeOfDay.now().minute);
  String _date = DateTime.now().year.toString() +
      "-" +
      DateTime.now().month.toString() +
      "-" +
      DateTime.now().day.toString();
  String _category;
  Color _selectedColor = Color(0xff6074F9);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("New Task")),
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
                      child: Text("Choose Color",
                          style: TextStyle(fontSize: defaultSize * 2)),
                    ),
                    SizedBox(height: SizeConfig.defaultSize * 1.4),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: defaultSize * 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedColor = Color(0xff6074F9);
                              });
                            },
                            child: Container(
                                width: defaultSize * 5,
                                height: defaultSize * 5,
                                decoration: BoxDecoration(
                                    color: Color(0xff6074F9),
                                    borderRadius: BorderRadius.circular(5),
                                    border:
                                        (_selectedColor == Color(0xff6074F9))
                                            ? Border.all(
                                                color: kPrimaryColor, width: 3)
                                            : null)),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedColor = Color(0xffE42B6A);
                              });
                            },
                            child: Container(
                                width: defaultSize * 5,
                                height: defaultSize * 5,
                                decoration: BoxDecoration(
                                    color: Color(0xffE42B6A),
                                    borderRadius: BorderRadius.circular(5),
                                    border:
                                        (_selectedColor == Color(0xffE42B6A))
                                            ? Border.all(
                                                color: kPrimaryColor, width: 3)
                                            : null)),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedColor = Color(0xff5ABB56);
                              });
                            },
                            child: Container(
                                width: defaultSize * 5,
                                height: defaultSize * 5,
                                decoration: BoxDecoration(
                                    color: Color(0xff5ABB56),
                                    borderRadius: BorderRadius.circular(5),
                                    border:
                                        (_selectedColor == Color(0xff5ABB56))
                                            ? Border.all(
                                                color: kPrimaryColor, width: 3)
                                            : null)),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedColor = Color(0xff3D3A62);
                              });
                            },
                            child: Container(
                                width: defaultSize * 5,
                                height: defaultSize * 5,
                                decoration: BoxDecoration(
                                    color: Color(0xff3D3A62),
                                    borderRadius: BorderRadius.circular(5),
                                    border:
                                        (_selectedColor == Color(0xff3D3A62))
                                            ? Border.all(
                                                color: kPrimaryColor, width: 3)
                                            : null)),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedColor = Color(0xffF4CA8F);
                              });
                            },
                            child: Container(
                                width: defaultSize * 5,
                                height: defaultSize * 5,
                                decoration: BoxDecoration(
                                    color: Color(0xffF4CA8F),
                                    borderRadius: BorderRadius.circular(5),
                                    border:
                                        (_selectedColor == Color(0xffF4CA8F))
                                            ? Border.all(
                                                color: kPrimaryColor, width: 3)
                                            : null)),
                          ),
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
                          FutureBuilder(
                              future: DBProvider.db.getAllCategories(),
                              builder: (context, AsyncSnapshot snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                    child: Text("Loading..."),
                                  );
                                } else if (snapshot.hasData) {
                                  return DropdownButton(
                                    value: _category,
                                    hint: Text("Select Category"),
                                    onChanged: (String value) {
                                      setState(() {
                                        _category = value;
                                      });
                                    },
                                    items: snapshot.data
                                        .map<DropdownMenuItem<String>>(
                                            (TaskCategory value) =>
                                                DropdownMenuItem<String>(
                                                  value: value.title,
                                                  child: Text(value.title,
                                                      style: TextStyle(
                                                          fontSize:
                                                              defaultSize * 2)),
                                                ))
                                        .toList(),
                                  );
                                } else if (snapshot.data.title == null) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                }
                                return Center(
                                    child: CircularProgressIndicator());
                              }),
                          /*DropdownButton(
                            value: _category,
                            hint: Text("Select Category"),
                            onChanged: (String value) {
                              setState(() {
                                _category = value;
                              });
                            },
                            items: <String>['Work', 'Personal', 'Sport']
                                .map<DropdownMenuItem<String>>(
                                    (String value) => DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value,
                                              style: TextStyle(
                                                  fontSize: defaultSize * 2)),
                                        ))
                                .toList(),
                          ),*/
                          IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                // Open an alertdialog to add a new catogory
                                Route route = MaterialPageRoute(
                                    builder: (context) => NewCategory());
                                Navigator.of(context)
                                    .push(route)
                                    .then((value) => setState(() {}));
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
                            "Add Task",
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
                              title: _title,
                              date: _date,
                              description: _description,
                              color: _selectedColor.value,
                              time: time);
                          DBProvider.db.insertTask(task);
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
}
