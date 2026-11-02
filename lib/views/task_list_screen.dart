import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/task.dart';
import '../viewmodels/app_bar_color_view_model.dart';
import '../viewmodels/task_view_model.dart';
import 'color_picker_dialog.dart';
import 'task_form_screen.dart';

const taskIcons = <String, IconData>{
  'laptop': Icons.laptop,
  'book': Icons.menu_book,
  'slides': Icons.co_present,
  'report': Icons.description,
};

class TaskListScreen extends ConsumerWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksAsync = ref.watch(taskViewModelProvider);
    final barColor = ref.watch(appBarColorViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: barColor,
        foregroundColor: Colors.white,
        title: const Text('Quản lý công việc'),
        actions: [
          IconButton(
            icon: const Icon(Icons.palette),
            onPressed: () => showDialog(context: context, builder: (_) => const ColorPickerDialog()),
          ),
        ],
      ),
      body: tasksAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Lỗi: $e')),
        data: (tasks) => ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: tasks.length,
          itemBuilder: (_, i) => _TaskCard(task: tasks[i]),
        ),
      ),
    );
  }
}

class _TaskCard extends StatelessWidget {
  final Task task;
  const _TaskCard({required this.task});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        leading: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(taskIcons[task.icon] ?? Icons.task_alt, color: Colors.grey.shade800),
        ),
        title: Text(task.title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Row(
          children: [
            const Icon(Icons.calendar_today_outlined, size: 14),
            const SizedBox(width: 4),
            Expanded(
              child: Text(task.description, maxLines: 1, overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => TaskFormScreen(task: task)),
          ),
        ),
      ),
    );
  }
}
