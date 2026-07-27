import 'package:flutter/material.dart';

/// A custom animation wrapper that floats a widget up and down periodically.
class FloatingAccent extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double offset;
  final double initialPhase;

  const FloatingAccent({
    super.key,
    required this.child,
    this.duration = const Duration(seconds: 6),
    this.offset = 15.0,
    this.initialPhase = 0.0,
  });

  @override
  State<FloatingAccent> createState() => _FloatingAccentState();
}

class _FloatingAccentState extends State<FloatingAccent>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);

    // Offset the animation start based on initial phase
    _controller.forward(from: widget.initialPhase);
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final double translation =
            Curves.easeInOut.transform(_controller.value) * widget.offset;
        return Transform.translate(
          offset: Offset(0, translation),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
