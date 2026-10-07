import 'package:flutter/material.dart';

class PuzzleCounterPill extends StatelessWidget {
  const PuzzleCounterPill({
    super.key,
    required this.child,
    required this.padding,
  });

  final Widget child;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) => FittedBox(
    fit: BoxFit.scaleDown,
    child: Container(
      padding: padding,
      decoration: BoxDecoration(
        color: const Color(0xF5FFFFFF),
        borderRadius: BorderRadius.circular(40),
      ),
      child: child,
    ),
  );
}
