import 'package:flutter/material.dart';

class PieceTileSurface extends StatelessWidget {
  const PieceTileSurface({
    super.key,
    required this.selected,
    required this.used,
    required this.child,
  });

  final bool selected;
  final bool used;
  final Widget child;

  @override
  Widget build(BuildContext context) => AnimatedContainer(
    duration: Duration(
      milliseconds: MediaQuery.disableAnimationsOf(context) ? 0 : 180,
    ),
    padding: const EdgeInsets.all(4),
    decoration: BoxDecoration(
      color: selected && !used
          ? const Color(0xFFE4F5F1)
          : const Color(0xFFF5F4F1),
      borderRadius: BorderRadius.circular(15),
      border: Border.all(
        color: selected && !used ? const Color(0xFF39B7AD) : Colors.transparent,
        width: 1.3,
      ),
      boxShadow: selected && !used
          ? const [
              BoxShadow(
                color: Color(0x1839B7AD),
                blurRadius: 10,
                offset: Offset(0, 3),
              ),
            ]
          : null,
    ),
    child: used
        ? ColorFiltered(
            colorFilter: const ColorFilter.matrix([
              .2126,
              .7152,
              .0722,
              0,
              0,
              .2126,
              .7152,
              .0722,
              0,
              0,
              .2126,
              .7152,
              .0722,
              0,
              0,
              0,
              0,
              0,
              1,
              0,
            ]),
            child: Opacity(opacity: .35, child: child),
          )
        : child,
  );
}
