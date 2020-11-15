import 'dart:io';

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
          "date TEXT"
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

    // Insert the Dog into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
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

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return Task(
        id: maps[i]['id'],
        title: maps[i]['title'],
        description: maps[i]['description'],
        color: maps[i]['color'],
        time: maps[i]['time'],
        date: maps[i]['date'],
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
    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return Task(
          id: maps[i]['id'],
          title: maps[i]['title'],
          description: maps[i]['description'],
          color: maps[i]['color'],
          time: maps[i]['time'],
          date: maps[i]['date']);
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

  Future<List<TaskCategory>> getCategoryById(int id) async {
    // Get a reference to the database.
    final Database db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps =
        await db.query('Category', where: "id = ?", whereArgs: [1]);
    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return TaskCategory(
        id: maps[i]['id'],
        title: maps[i]['title'],
        color: maps[i]['color'],
      );
    });
  }
}
