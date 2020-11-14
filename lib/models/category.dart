class Category {
  int id;
  String name;
  int items;

  Category({this.id, this.name, this.items});
  //Category.withId(this._id, this._name);

  /*String get id => _id;
  String get name => _name;

  set name(String newName) {
    if (newName.length <= 255) {
      this._name = newName;
    }
  }*/
}

// Sample Data
List<Category> categories = [
  Category(id: 1, name: "Sport", items: 4),
  Category(id: 2, name: "Study", items:1),
  Category(id: 3, name: "Work", items: 4),
  Category(id: 4, name: "Personal", items: 9),
];
