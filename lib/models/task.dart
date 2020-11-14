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
  bool isFinished;
  String category;

  Task({
    this.id,
    this.title,
    //this.date,
    //this.isFinished,
    this.description,
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
       
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'description': description,
      };
}
