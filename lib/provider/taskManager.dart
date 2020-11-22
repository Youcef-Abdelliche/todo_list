
import 'package:flutter/material.dart';
import 'package:todo_list/models/task_category.dart';

class TaskManager extends ChangeNotifier {
  List<dynamic> tasks = [];
  Color selectedColor = Color(0xff6074F9);
  TimeOfDay time = TimeOfDay(hour: TimeOfDay.now().hour, minute: TimeOfDay.now().minute);
  String date = DateTime.now().year.toString() +
      "-" +
      DateTime.now().month.toString() +
      "-" +
      DateTime.now().day.toString();
  String categoryTitle;
  List<TaskCategory> listCategories;
  int categoryId;
  
  updateTaskList(List<dynamic> list) {
    tasks = list;
    notifyListeners();
  }

  updateColor(int value) {
    selectedColor = Color(value);
    notifyListeners();
  }

  /*updateTime(TimeOfDay value){
    time = value;
    notifyListeners();
  }

  updateDate(String value){
    date = value;
    notifyListeners();
  }

  updateCategory(String value1, List<TaskCategory> value2, int value3){
    categoryTitle = value1;
    listCategories = value2;
    categoryId = value3;
    notifyListeners();
  }*/
}