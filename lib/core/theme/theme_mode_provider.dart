import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider for managing the global application [ThemeMode].
final themeModeProvider =
    NotifierProvider<ThemeNotifier, ThemeMode>(ThemeNotifier.new);

/// Riverpod [Notifier] that manages Light / Dark / System theme switching.
class ThemeNotifier extends Notifier<ThemeMode> {
  @override
  ThemeMode build() => ThemeMode.dark;

  /// Toggles between Dark and Light mode.
  void toggle() {
    state = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
  }

  /// Explicitly set the theme mode.
  void setTheme(ThemeMode mode) {
    state = mode;
  }

  /// Alias for setting the theme mode.
  void setMode(ThemeMode mode) {
    state = mode;
  }

  /// Sets dark mode directly.
  void setDark() {
    state = ThemeMode.dark;
  }

  /// Sets light mode directly.
  void setLight() {
    state = ThemeMode.light;
  }

  /// Sets system theme mode.
  void setSystem() {
    state = ThemeMode.system;
  }
}

/// Backwards compatibility alias for [ThemeNotifier]
typedef ThemeModeNotifier = ThemeNotifier;

/// Pure helper function to compute next theme mode
ThemeMode nextThemeMode(ThemeMode current) {
  return current == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
}
