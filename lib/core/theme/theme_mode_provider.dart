import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final StateProvider<ThemeMode> themeModeProvider =
    StateProvider<ThemeMode>((_) => ThemeMode.system);

ThemeMode nextThemeMode(ThemeMode current) {
  if (current == ThemeMode.dark) {
    return ThemeMode.light;
  }
  return ThemeMode.dark;
}
