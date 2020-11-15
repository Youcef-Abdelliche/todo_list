import 'dart:convert';

Task taskFromJson(String str) {
  final jsonData = json.decode(str);
  return Task.fromMap(jsonData);
}

String taskToJson(Task data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Task {
  int id;
  String title;
  String description;
  String date;
  int time;
  bool isFinished;
  String category;
  int color;

  Task({
    this.id,
    this.title,
    this.time,
    //this.isFinished,
    this.description,
    this.color,
    this.date,
    //this.category,
  });

  /*factory Task.fromMap(Map<String, dynamic> json) => new Task(
        id: json["id"],
        title: json["title"],
        description: json["description"],
      );*/

  factory Task.fromMap(Map<String, dynamic> json) => new Task(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        color: json["color"],
        time: json['time'],
        date: json['date'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'description': description,
        'color': color,
        'time': time,
        'date': date,
      };
}
