import 'package:sqflite/sqflite.dart';

import '../models/task.dart';
import 'app_database.dart';

class TaskRepository {
  static const _table = 'tasks';

  Future<Database> get _db => AppDatabase.instance.database;

  Future<List<Task>> getAll() async {
    final db = await _db;
    final rows = await db.query(_table, orderBy: 'id ASC');
    return rows.map(Task.fromMap).toList();
  }

  Future<int> update(Task t) async {
    final db = await _db;
    return db.update(_table, t.toMap(), where: 'id = ?', whereArgs: [t.id]);
  }
}
