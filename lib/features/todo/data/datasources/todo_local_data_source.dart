
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/todo_model.dart';

class TodoLocalDataSource {
  static const String _tableName = "todos";
  static Database? _database;

  Future<Database> _getDatabase() async {
    if(_database != null) return _database!;

    final dbPath = await getDatabasesPath();
    final path = join(dbPath,'todo_app.db');

    _database = await openDatabase(
        path,
        version: 1,
        onCreate: (db,version){
          db.execute(
              '''
            CREATE TABLE $_tableName (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            description TEXT
          )
            '''
          );
        }
    );
    return _database!;
  }

  Future<void> addTodo(TodoModel todo) async {
    final db = await _getDatabase();
    await db.insert(_tableName, todo.toMap());
  }

  Future<List<TodoModel>> getAllTodos() async  {
    final db = await _getDatabase();
    final result = await db.query(_tableName);
    return result.map((map) => TodoModel.fromMap(map)).toList();
  }

  Future<void> updateTodo(TodoModel todo) async {
    final db = await _getDatabase();
    await db.update(
        _tableName, todo.toMap(),
        where: 'id = ?',
        whereArgs: [todo.id]
    );
  }

  Future<void> deleteTodo(int id) async {
    final db = await _getDatabase();
    await db.delete(
        _tableName,
        where: 'id = ?',
        whereArgs: [id]
    );
  }
}


