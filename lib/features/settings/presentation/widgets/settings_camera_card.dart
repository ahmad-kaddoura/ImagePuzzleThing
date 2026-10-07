import 'package:flutter/material.dart';

class SettingsCameraCard extends StatelessWidget {
  const SettingsCameraCard({
    super.key,
    required this.busy,
    required this.selected,
    required this.onTap,
  });
  final bool busy;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    label: 'Take a photo',
    selected: selected,
    child: Material(
      color: selected ? const Color(0xFFE4F4F0) : const Color(0xFFF3F4F0),
      borderRadius: BorderRadius.circular(17),
      child: InkWell(
        onTap: busy ? null : onTap,
        borderRadius: BorderRadius.circular(17),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.photo_camera_outlined,
              size: 28,
              color: Color(0xFF173D3B),
            ),
            SizedBox(height: 8),
            Text(
              'Take a photo',
              maxLines: 1,
              style: TextStyle(fontSize: 11, color: Color(0xFF3E5C5D)),
            ),
          ],
        ),
      ),
    ),
  );
}
