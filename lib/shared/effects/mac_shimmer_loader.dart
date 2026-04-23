import 'package:flutter/material.dart';

class MacShimmerLoader extends StatefulWidget {
  const MacShimmerLoader({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  State<MacShimmerLoader> createState() => _MacShimmerLoaderState();
}

class _MacShimmerLoaderState extends State<MacShimmerLoader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1400),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? _) {
        return ShaderMask(
          shaderCallback: (Rect bounds) {
            return LinearGradient(
              begin: Alignment(-1.2 + (_controller.value * 2.4), -0.1),
              end: Alignment(1.2 + (_controller.value * 2.4), 0.1),
              colors: const <Color>[
                Color(0xFFF5F5F7),
                Color(0xFFE5E7EB),
                Color(0xFFF5F5F7),
              ],
              stops: const <double>[0.2, 0.5, 0.8],
            ).createShader(bounds);
          },
          blendMode: BlendMode.srcATop,
          child: widget.child,
        );
      },
    );
  }
}
