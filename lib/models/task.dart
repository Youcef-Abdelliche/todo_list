import 'package:todo_list/models/task_category.dart';

class Task {
  int id;
  String title;
  String description;
  String date;
  int time;
  bool isFinished;
  int categoryId;
  int color;
  TaskCategory taskCategory;

  Task({
    this.id,
    this.title,
    this.time,
    this.isFinished,
    this.description,
    this.color,
    this.date,
    this.categoryId,
    this.taskCategory,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'description': description,
        'color': color,
        'time': time,
        'date': date,
        'categoryId': categoryId,
        'isFinished': (isFinished) ? 1 : 0,
      };
}
