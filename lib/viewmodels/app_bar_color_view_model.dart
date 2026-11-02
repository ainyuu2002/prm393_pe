import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'providers.dart';

part 'app_bar_color_view_model.g.dart';

const appBarColors = <Color>[
  Colors.blue,
  Colors.green,
  Colors.purple,
  Colors.teal,
  Colors.orange,
  Colors.red,
  Colors.pink,
  Colors.blueGrey,
];

@Riverpod(keepAlive: true)
class AppBarColorViewModel extends _$AppBarColorViewModel {
  static const _key = 'app_bar_color';

  @override
  Color build() {
    final saved = ref.read(sharedPrefsProvider).getInt(_key);
    return saved == null ? Colors.blue : Color(saved);
  }

  Future<void> select(Color c) async {
    state = c;
    await ref.read(sharedPrefsProvider).setInt(_key, c.toARGB32());
  }
}
