import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_list/models/task_category.dart';
import 'package:todo_list/models/task.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "taskList.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Task ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,"
          "title TEXT DEFAULT 'TASK',"
          "description TEXT DEFAULT 'no description',"
          "color INTEGER,"
          "time INTEGER,"
          "date TEXT,"
          "categoryId INTEGER,"
          "FOREIGN KEY(categoryId) references Category(id) ON DELETE CASCADE"
          ")");
      await db.execute("CREATE TABLE Category ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,"
          "title TEXT DEFAULT 'category name',"
          "color INTEGER"
          ")");
    });
  }

  Future<void> insertTask(Task task) async {
    // Get a reference to the database.
    final Database db = await database;
    await db.insert(
      'Task',
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Task>> getAllTasks() async {
    // Get a reference to the database.
    final Database db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('Task');
    List<TaskCategory> taskCategories = await getAllCategories();
    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      TaskCategory taskCategory = taskCategories
          .where((element) => element.id == maps[i]['categoryId'])
          .toList()[0];
      return Task(
        id: maps[i]['id'],
        title: maps[i]['title'],
        description: maps[i]['description'],
        color: maps[i]['color'],
        time: maps[i]['time'],
        date: maps[i]['date'],
        //categoryId: maps[i]['categoryId'],
        taskCategory: taskCategory,
      );
    });
  }

  Future<List<Task>> getTodayTasks() async {
    String date = DateTime.now().year.toString() +
        "-" +
        DateTime.now().month.toString() +
        "-" +
        DateTime.now().day.toString();
    // Get a reference to the database.
    final Database db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps =
        await db.query('Task', where: "date = ?", whereArgs: [date]);
    List<TaskCategory> taskCategories = await getAllCategories();
    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      TaskCategory taskCategory = taskCategories
          .where((element) => element.id == maps[i]['categoryId'])
          .toList()[0];
      return Task(
        id: maps[i]['id'],
        title: maps[i]['title'],
        description: maps[i]['description'],
        color: maps[i]['color'],
        time: maps[i]['time'],
        date: maps[i]['date'],
        //categoryId: maps[i]['categoryId'],
        taskCategory: taskCategory,
      );
    });
  }

  // Delete a task by id
  deleteTask(int id) async {
    final db = await database;
    db.delete("Task", where: "id = ?", whereArgs: [id]);
  }

  // Add Category
  Future<void> insertCategory(TaskCategory category) async {
    // Get a reference to the database.
    final Database db = await database;

    // Insert the Dog into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'Category',
      category.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Get categories
  Future<List<TaskCategory>> getAllCategories() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('Category');

    return List.generate(maps.length, (i) {
      return TaskCategory(
        id: maps[i]['id'],
        title: maps[i]['title'],
        color: maps[i]['color'],
      );
    });
  }

  // Get a category by id
  Future<TaskCategory> getCategoryById(int id) async {
    // Get a reference to the database.
    final Database db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps =
        await db.query('Category', where: "id = ?", whereArgs: [1]);
    // Convert the List<Map<String, dynamic> into a List<Dog>.
    List<TaskCategory> category = List.generate(maps.length, (i) {
      return TaskCategory(
        id: maps[i]['id'],
        title: maps[i]['title'],
        color: maps[i]['color'],
      );
    });
    return category[0];
  }

  // Delete a category by id
  deleteCategory(int id) async {
    final db = await database;
    db.delete("Category", where: "id = ?", whereArgs: [id]);
  }

  Future<Map<DateTime, List<dynamic>>> getEvents() async {
    Map<DateTime, List<dynamic>> events = {};
    List<Task> tasks = await getAllTasks();
    List<String> dates = await getEventsDates();

    //List<TaskWidget> taskList = [];
    //List<dynamic> list = [];
    for (var date in dates) {
      List<Task> tList =
          tasks.where((element) => element.date == date).toList();

      DateTime dateTime = DateTime.parse(date);

      events[dateTime] = tList;
    }

    return events;
  }

  Future<List<Task>> getTaskByDate(String date) async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query('Task', where: "date = ?", whereArgs: [date]);
    List<TaskCategory> taskCategories = await getAllCategories();
    return List.generate(maps.length, (i) {
      TaskCategory taskCategory = taskCategories
          .where((element) => element.id == maps[i]['categoryId'])
          .toList()[0];
      return Task(
        id: maps[i]['id'],
        title: maps[i]['title'],
        description: maps[i]['description'],
        color: maps[i]['color'],
        time: maps[i]['time'],
        date: maps[i]['date'],
        //categoryId: maps[i]['categoryId'],
        taskCategory: taskCategory,
      );
    });
  }

  Future<List<String>> getEventsDates() async {
    List<Task> tasks = await getAllTasks();
    List<String> dateList = [];
    for (var item in tasks) {
      if (!dateList.contains(item.date)) {
        dateList.add(item.date);
      }
    }
    return dateList;
  }

  updateTask(Task task) async {
    print(task.id.toString() + " "+ task.title + " "+ task.description);
    final db = await database;
    await db.update(
      "Task",
      {
        "id": task.id,
        "title": task.title,
        "description": task.description,
        "time": task.time,
        "date": task.date,
        "categoryId": task.categoryId
      },
      where: "id = ?",
      whereArgs: [task.id],
      //conflictAlgorithm: ConflictAlgorithm.replace,
    );
    debugPrint("task updated");
  }
}
