class TaskCategory {
  int id;
  String title;
  int items;
  int itemsFinished;
  int color;

  TaskCategory(
      {this.id, this.title, this.color, this.items, this.itemsFinished});

  factory TaskCategory.fromMap(Map<String, dynamic> json) => new TaskCategory(
        id: json["id"],
        title: json["title"],
        color: json["color"],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'color': color,
      };
}
