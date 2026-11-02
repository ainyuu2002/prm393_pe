import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../viewmodels/app_bar_color_view_model.dart';

class ColorPickerDialog extends ConsumerWidget {
  const ColorPickerDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(appBarColorViewModelProvider);

    return AlertDialog(
      title: const Text('Chọn màu thanh ứng dụng'),
      content: Wrap(
        spacing: 16,
        runSpacing: 16,
        children: [
          for (final c in appBarColors)
            InkWell(
              customBorder: const CircleBorder(),
              onTap: () => ref.read(appBarColorViewModelProvider.notifier).select(c),
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: c,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: c.toARGB32() == selected.toARGB32() ? Colors.black : Colors.transparent,
                    width: 3,
                  ),
                ),
                child: c.toARGB32() == selected.toARGB32()
                    ? const Icon(Icons.check, color: Colors.white)
                    : null,
              ),
            ),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Đóng')),
      ],
    );
  }
}
