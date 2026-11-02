import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/task_repository.dart';

part 'providers.g.dart';

@Riverpod(keepAlive: true)
SharedPreferences sharedPrefs(Ref ref) => throw UnimplementedError('Override trong main()');

@Riverpod(keepAlive: true)
TaskRepository taskRepository(Ref ref) => TaskRepository();