import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  static final AppDatabase instance = AppDatabase._();
  AppDatabase._();

  static const _fileName = 'app_database.db';

  Future<Database>? _db;
  Future<Database> get database => _db ??= _open();

  Future<Database> _open() async {
    final path = join(await getDatabasesPath(), _fileName);
    return openDatabase(
      path,
      version: 1,
      onConfigure: (db) => db.execute('PRAGMA foreign_keys = ON'),
      onCreate: (db, version) async {
        for (final s in _schema) {
          await db.execute(s);
        }
        debugPrint('AppDatabase: đã tạo 1 bảng + dữ liệu mẫu');
      },
    );
  }

  Future<void> reset() async {
    final path = join(await getDatabasesPath(), _fileName);
    if (_db != null) await (await _db!).close();
    _db = null;
    await deleteDatabase(path);
  }

  static const _schema = <String>[
    r'''
      CREATE TABLE tasks (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT NOT NULL,
      description TEXT,
      is_done INTEGER NOT NULL DEFAULT 0,
      icon TEXT NOT NULL DEFAULT 'task'
      )
    ''',
    r'''
      INSERT INTO tasks (title, description, is_done, icon) VALUES
      ('Làm bài tập Flutter', 'Hoàn thành trước thứ Sáu', 0, 'laptop'),
      ('Ôn tập Riverpod', 'Xem lại bài giảng MVVM', 0, 'book'),
      ('Chuẩn bị bài thuyết trình', 'Nhóm 4 - Chủ đề Firebase', 0, 'slides'),
      ('Viết báo cáo môn học', 'Nộp trên LMS', 0, 'report')
    ''',
  ];
}