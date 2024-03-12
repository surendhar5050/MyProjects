import 'package:flutter/material.dart';

class LikeAnimation extends StatefulWidget {
  const LikeAnimation(
      {super.key,
      required this.child,
      required this.isAnimating,
      this.duration = const Duration(milliseconds: 150),
      this.onEnd,
      this.smallLike = false});
  final Widget child;
  final bool isAnimating;
  final Duration duration;
  final VoidCallback? onEnd;
  final bool smallLike;
  @override
  State<LikeAnimation> createState() => _LikeAnimationState();
}

class _LikeAnimationState extends State<LikeAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> scale;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: widget.duration.inMilliseconds ~/ 2));
    scale = Tween<double>(begin: 1, end: 1.2).animate(_animationController);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant LikeAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isAnimating != oldWidget.isAnimating) {
      startAnimation();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scale,
      child: widget.child,
    );
  }

  void startAnimation() async {
    if (widget.isAnimating || widget.smallLike) {
      await _animationController.forward();
      await _animationController.reverse();
      await Future.delayed(const Duration(
        milliseconds: 200,
      ));
      if (widget.onEnd != null) {
        widget.onEnd!();
      }
    }
  }
}
