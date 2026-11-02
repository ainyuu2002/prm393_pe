import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/task.dart';
import 'providers.dart';

part 'task_view_model.g.dart';

@riverpod
class TaskViewModel extends _$TaskViewModel {
  @override
  Future<List<Task>> build() => ref.read(taskRepositoryProvider).getAll();

  Future<void> edit(Task t) async {
    await ref.read(taskRepositoryProvider).update(t);
    ref.invalidateSelf();
  }
}
