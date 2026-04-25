import 'package:flutter/widgets.dart';

typedef CursorMagnetCallback = void Function(bool expanded);

class CursorMagnetScope extends InheritedWidget {
  const CursorMagnetScope({
    required this.onMagnetize,
    required super.child,
    super.key,
  });

  final CursorMagnetCallback onMagnetize;

  static CursorMagnetCallback? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<CursorMagnetScope>()
        ?.onMagnetize;
  }

  @override
  bool updateShouldNotify(CursorMagnetScope oldWidget) {
    return oldWidget.onMagnetize != onMagnetize;
  }
}
