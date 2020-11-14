import 'package:flutter/material.dart';
import 'package:todo_list/constants.dart';
import 'package:todo_list/models/task.dart';
import 'package:todo_list/provider/databaseProvider.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("New Task")),
        body: Container(
            margin: EdgeInsets.all(defaultSize * 2),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildTitleField(),
                  SizedBox(height: SizeConfig.defaultSize * 1.4),
                  buildDescriptionField(),
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
                        Task task =
                            new Task(title: _title, description: _description);
                        DBProvider.db.insertTask(task);
                        Navigator.of(context).pop();
                      }
                    },
                  )
                ],
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
