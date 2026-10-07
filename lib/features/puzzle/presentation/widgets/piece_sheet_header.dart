import 'package:flutter/material.dart';

class PieceSheetHeader extends StatelessWidget {
  const PieceSheetHeader({
    super.key,
    required this.remaining,
    required this.total,
    required this.expanded,
    required this.onToggle,
    required this.onDragUpdate,
    required this.onDragEnd,
  });

  final int remaining;
  final int total;
  final bool expanded;
  final VoidCallback onToggle;
  final GestureDragUpdateCallback onDragUpdate;
  final GestureDragEndCallback onDragEnd;

  @override
  Widget build(BuildContext context) => GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: onToggle,
    onVerticalDragUpdate: onDragUpdate,
    onVerticalDragEnd: onDragEnd,
    child: Column(
      children: [
        Semantics(
          button: true,
          label: expanded ? 'Collapse pieces' : 'Expand all pieces',
          child: GestureDetector(
            key: const ValueKey('piece-sheet-handle'),
            behavior: HitTestBehavior.opaque,
            onTap: onToggle,
            child: SizedBox(
              height: 16,
              width: double.infinity,
              child: Center(
                child: Container(
                  width: 34,
                  height: 5,
                  decoration: BoxDecoration(
                    color: const Color(0xFFDFE0DF),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
          child: Row(
            children: [
              const Text(
                'Your pieces',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF142E33),
                ),
              ),
              const Spacer(),
              Text(
                '$remaining left',
                style: const TextStyle(fontSize: 13, color: Color(0xFF7B8B90)),
              ),
            ],
          ),
        ),
        if (expanded)
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '${total - remaining} placed · $total pieces in all',
                style: const TextStyle(fontSize: 12, color: Color(0xFF7B8B90)),
              ),
            ),
          ),
      ],
    ),
  );
}
