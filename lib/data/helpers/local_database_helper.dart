// ignore_for_file: depend_on_referenced_packages

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:up_todo_app/data/requests/requests.dart';
import 'package:up_todo_app/data/responses/responses.dart';

class LocalDatabaseHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    // If _database is null, initialize it
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    // Get the path to the database file
    String path = join(await getDatabasesPath(), 'up_todo.db');

    // Open or create the database at the specified path
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        // Create the tasks table
        await db.execute(
          "CREATE TABLE todos(id INTEGER, todo String, completed INTEGER, userId INTEGER)",
        );
      },
    );
  }

  Future<void> addTodoToLocal(AddTodoRequestBody addTodoRequestBody) async {
    final Database db = await database;
    await db.insert("todos", {
      "id": addTodoRequestBody.id,
      "todo": addTodoRequestBody.todo,
      "completed": addTodoRequestBody.completed ? 1 : 0,
      "userId": addTodoRequestBody.userId
    });
  }

  Future<void> deleteTodoFromLocal(int todoID) async {
    final Database db = await database;
    await db.delete("todos", where: "id = ?", whereArgs: [todoID]);
  }

  Future<void> editTodoInLocal(
      UpdateTodoRequestBody updateTodoRequestBody) async {
    final Database db = await database;
    await db.update(
      "todos",
      {"completed": "${updateTodoRequestBody.completed ? 1 : 0}"},
      where: "id = ?",
      whereArgs: [updateTodoRequestBody.id],
    );
  }

  Future<GetAllTodosByUserIdResponse> getAllTodosFromLocal() async {
    final Database db = await database;
    List<Map<String, Object?>> todos = await db.query(
      "todos",
    );
    List<TodoResponse> todosData = [];
    for (var element in todos) {
      todosData.add(TodoResponse.fromJson({
        "id": element["id"],
        "todo": element["todo"],
        "completed": element["completed"] == 1 ? true : false,
        "userId": element["userId"],
      }));
    }

    return GetAllTodosByUserIdResponse(
      todosData: todosData,
      total: 0,
      limit: 0,
      skip: 0,
    );
  }

  Future<void> saveTodosFromRemoteToLocal(
      GetAllTodosByUserIdResponse getAllTodosByUserIdResponse) async {
    final Database db = await database;

    getAllTodosByUserIdResponse.todosData?.forEach((element) async {
      await db.insert(
        "todos",
        {
          "id": element.id,
          "todo": element.todo,
          "completed": element.completed == true ? 1 : 0,
          "userId": element.userId
        },
      );
    });
  }

  Future<void> deleteDatabase() async {
    final Database db = await database;
    await db.delete("todos");
    // await databaseFactory.deleteDatabase(db.path);
  }
}
