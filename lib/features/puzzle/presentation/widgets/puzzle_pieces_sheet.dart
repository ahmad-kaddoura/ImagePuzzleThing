import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../controllers/puzzle_controller.dart';
import 'piece_sheet_content.dart';

class PuzzlePiecesSheet extends StatefulWidget {
  const PuzzlePiecesSheet({
    super.key,
    required this.image,
    required this.controller,
    required this.collapsedHeight,
    required this.feedbackCell,
  });

  final ui.Image image;
  final PuzzleController controller;
  final double collapsedHeight;
  final double feedbackCell;

  @override
  State<PuzzlePiecesSheet> createState() => _PuzzlePiecesSheetState();
}

class _PuzzlePiecesSheetState extends State<PuzzlePiecesSheet> {
  final _sheet = DraggableScrollableController();
  bool _expanded = false;
  double _minimum = .22;
  double _height = 1;

  void _move(double extent) {
    if (!_sheet.isAttached) return;
    if (MediaQuery.disableAnimationsOf(context)) {
      _sheet.jumpTo(extent);
    } else {
      _sheet.animateTo(
        extent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
      );
    }
  }

  void _drag(DragUpdateDetails details) {
    if (!_sheet.isAttached) return;
    _sheet.jumpTo(
      (_sheet.size - details.delta.dy / _height).clamp(_minimum, .82),
    );
  }

  void _release(DragEndDetails details) {
    if (!_sheet.isAttached) return;
    final speed = details.primaryVelocity ?? 0;
    if (speed.abs() > 300) {
      _move(speed < 0 ? .82 : _minimum);
      return;
    }
    final stops = [_minimum, (_minimum + .82) / 2, .82];
    stops.sort(
      (a, b) => (a - _sheet.size).abs().compareTo((b - _sheet.size).abs()),
    );
    _move(stops.first);
  }

  void _select(int id) {
    widget.controller.select(id);
    _move(_minimum);
  }

  @override
  void dispose() {
    _sheet.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      _height = constraints.maxHeight;
      _minimum = min(.70, widget.collapsedHeight / constraints.maxHeight);
      return NotificationListener<DraggableScrollableNotification>(
        onNotification: (notification) {
          final expanded = notification.extent > _minimum + .07;
          if (expanded != _expanded) setState(() => _expanded = expanded);
          return true;
        },
        child: DraggableScrollableSheet(
          controller: _sheet,
          initialChildSize: _minimum,
          minChildSize: _minimum,
          maxChildSize: .82,
          snap: true,
          snapSizes: [_minimum, (_minimum + .82) / 2, .82],
          builder: (context, scrollController) => PieceSheetContent(
            image: widget.image,
            controller: widget.controller,
            scrollController: scrollController,
            expanded: _expanded,
            feedbackCell: widget.feedbackCell,
            onToggle: () => _move(_expanded ? _minimum : .82),
            onDragUpdate: _drag,
            onDragEnd: _release,
            onSelect: _select,
            onDragStarted: () => _move(_minimum),
          ),
        ),
      );
    },
  );
}
