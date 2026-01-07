import 'dart:async';
import 'package:flutter/material.dart';

class FadeInEntry extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Offset offset;

  const FadeInEntry({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 400),
    this.delay = Duration.zero,
    this.offset = const Offset(0, 20),
  });

  @override
  State<FadeInEntry> createState() => _FadeInEntryState();
}

class _FadeInEntryState extends State<FadeInEntry>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<Offset> _offset;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _opacity = _controller.drive(CurveTween(curve: Curves.easeOut));
    _offset = _controller.drive(
      Tween<Offset>(
        begin: widget.offset,
        end: Offset.zero,
      ).chain(CurveTween(curve: Curves.easeOutCubic)),
    );

    if (widget.delay == Duration.zero) {
      _controller.forward();
    } else {
      _timer = Timer(widget.delay, () {
        if (mounted) _controller.forward();
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _opacity.value,
          child: Transform.translate(offset: _offset.value, child: child),
        );
      },
      child: widget.child,
    );
  }
}
