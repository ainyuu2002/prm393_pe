import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/task.dart';
import '../viewmodels/app_bar_color_view_model.dart';
import '../viewmodels/task_view_model.dart';

class TaskFormScreen extends ConsumerStatefulWidget {
  final Task task;
  const TaskFormScreen({super.key, required this.task});

  @override
  ConsumerState<TaskFormScreen> createState() => _TaskFormScreenState();
}

class _TaskFormScreenState extends ConsumerState<TaskFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final _titleCtrl = TextEditingController(text: widget.task.title);
  late final _descCtrl = TextEditingController(text: widget.task.description);
  late bool _isDone = widget.task.isDone;

  @override
  void dispose() {
    _titleCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final t = widget.task.copyWith(
      title: _titleCtrl.text.trim(),
      description: _descCtrl.text.trim(),
      isDone: _isDone,
    );
    await ref.read(taskViewModelProvider.notifier).edit(t);
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final barColor = ref.watch(appBarColorViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: barColor,
        foregroundColor: Colors.white,
        title: const Text('Chỉnh sửa công việc'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _titleCtrl,
              decoration: const InputDecoration(labelText: 'Tiêu đề *', border: OutlineInputBorder()),
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Vui lòng nhập tiêu đề' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _descCtrl,
              decoration: const InputDecoration(labelText: 'Mô tả', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 4),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Đã hoàn thành'),
              value: _isDone,
              onChanged: (v) => setState(() => _isDone = v),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Hủy'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(onPressed: _save, child: const Text('Lưu')),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}