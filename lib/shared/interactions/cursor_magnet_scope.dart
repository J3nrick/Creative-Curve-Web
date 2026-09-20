import 'dart:math' as math;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

typedef CursorMagnetCallback = void Function(bool expanded);

/// A high-performance, reusable magnetic hover widget that attracts child
/// elements (such as buttons, navigation links, and badges) towards the pointer
/// using [MouseRegion] and [Transform.translate] with spring physics.
class CursorMagnetScope extends StatefulWidget {
  const CursorMagnetScope({
    required this.child,
    this.maxDistance = 10.0,
    this.strength = 0.28,
    this.springDuration = const Duration(milliseconds: 280),
    this.onMagnetize,
    this.enabled = true,
    this.curve = Curves.easeOutQuart,
    super.key,
  });

  /// The child widget to apply magnetic translation physics to.
  final Widget child;

  /// Maximum translational distance in pixels from original rest position.
  final double maxDistance;

  /// Magnet attraction strength factor (0.0 to 1.0).
  final double strength;

  /// Duration of spring-back animation upon cursor exit.
  final Duration springDuration;

  /// Optional callback triggered when magnetic state changes.
  final CursorMagnetCallback? onMagnetize;

  /// Whether magnetic physics are enabled.
  final bool enabled;

  /// Damping curve for smooth magnetic tracking.
  final Curve curve;

  /// Helper to lookup nearest magnet callback in the widget tree.
  static CursorMagnetCallback? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_InheritedCursorMagnet>()
        ?.onMagnetize;
  }

  @override
  State<CursorMagnetScope> createState() => _CursorMagnetScopeState();
}

class _CursorMagnetScopeState extends State<CursorMagnetScope>
    with SingleTickerProviderStateMixin {
  late final AnimationController _springController;
  late Animation<Offset> _offsetAnimation;
  Offset _currentOffset = Offset.zero;
  Offset _targetOffset = Offset.zero;
  Size _widgetSize = Size.zero;

  @override
  void initState() {
    super.initState();
    _springController = AnimationController(
      vsync: this,
      duration: widget.springDuration,
    )..addListener(() {
        setState(() {
          _currentOffset = _offsetAnimation.value;
        });
      });

    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset.zero,
    ).animate(_springController);
  }

  @override
  void dispose() {
    _springController.dispose();
    super.dispose();
  }

  void _updateMagnetTarget(Offset localPosition) {
    if (!widget.enabled || _widgetSize == Size.zero) return;

    final Offset center = Offset(
      _widgetSize.width / 2,
      _widgetSize.height / 2,
    );

    final double deltaX = localPosition.dx - center.dx;
    final double deltaY = localPosition.dy - center.dy;

    double targetX = deltaX * widget.strength;
    double targetY = deltaY * widget.strength;

    final double distance = math.sqrt(targetX * targetX + targetY * targetY);
    if (distance > widget.maxDistance && distance > 0) {
      final double scale = widget.maxDistance / distance;
      targetX *= scale;
      targetY *= scale;
    }

    _targetOffset = Offset(targetX, targetY);

    // Smoothly step towards target
    _springController.stop();
    _offsetAnimation = Tween<Offset>(
      begin: _currentOffset,
      end: _targetOffset,
    ).animate(
      CurvedAnimation(
        parent: _springController,
        curve: Curves.easeOutCubic,
      ),
    );
    _springController.forward(from: 0.0);
  }

  void _handleHover(PointerHoverEvent event) {
    _updateMagnetTarget(event.localPosition);
  }

  void _handleEnter(PointerEnterEvent event) {
    widget.onMagnetize?.call(true);
    _updateMagnetTarget(event.localPosition);
  }

  void _handleExit(PointerExitEvent event) {
    widget.onMagnetize?.call(false);
    _targetOffset = Offset.zero;

    _springController.stop();
    _offsetAnimation = Tween<Offset>(
      begin: _currentOffset,
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _springController,
        curve: widget.curve,
      ),
    );
    _springController.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedCursorMagnet(
      onMagnetize: widget.onMagnetize,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return MouseRegion(
            cursor: SystemMouseCursors.click,
            onEnter: _handleEnter,
            onHover: _handleHover,
            onExit: _handleExit,
            child: NotificationListener<SizeChangedLayoutNotification>(
              onNotification: (_) {
                _updateSize(context);
                return true;
              },
              child: _SizeReporter(
                onSizeChanged: (Size size) => _widgetSize = size,
                child: Transform.translate(
                  offset: _currentOffset,
                  child: widget.child,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _updateSize(BuildContext context) {
    final RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox != null && renderBox.hasSize) {
      _widgetSize = renderBox.size;
    }
  }
}

class _SizeReporter extends StatefulWidget {
  const _SizeReporter({
    required this.child,
    required this.onSizeChanged,
  });

  final Widget child;
  final ValueChanged<Size> onSizeChanged;

  @override
  State<_SizeReporter> createState() => _SizeReporterState();
}

class _SizeReporterState extends State<_SizeReporter> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _reportSize());
  }

  void _reportSize() {
    if (!mounted) return;
    final RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox != null && renderBox.hasSize) {
      widget.onSizeChanged(renderBox.size);
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _reportSize());
    return widget.child;
  }
}

class _InheritedCursorMagnet extends InheritedWidget {
  const _InheritedCursorMagnet({
    required this.onMagnetize,
    required super.child,
  });

  final CursorMagnetCallback? onMagnetize;

  @override
  bool updateShouldNotify(_InheritedCursorMagnet oldWidget) {
    return oldWidget.onMagnetize != onMagnetize;
  }
}
