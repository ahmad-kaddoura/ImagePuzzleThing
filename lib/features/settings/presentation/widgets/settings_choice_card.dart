import 'package:flutter/material.dart';

class SettingsChoiceCard extends StatelessWidget {
  const SettingsChoiceCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    selected: selected,
    label: '$title, $subtitle',
    child: GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFE4F4F0) : const Color(0xFFF5F4F1),
          border: Border.all(
            color: selected ? const Color(0xFF1C9A88) : Colors.transparent,
            width: 1.4,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        constraints: const BoxConstraints(minHeight: 94),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 26,
              color: selected
                  ? const Color(0xFF187A6E)
                  : const Color(0xFF607477),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF172E32),
              ),
            ),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 11, color: Color(0xFF718389)),
            ),
          ],
        ),
      ),
    ),
  );
}
