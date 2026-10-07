import 'package:flutter/material.dart';

class SettingsImageCard extends StatelessWidget {
  const SettingsImageCard({
    super.key,
    required this.label,
    required this.image,
    required this.selected,
    required this.onTap,
    this.icon = Icons.photo_library_outlined,
  });

  final String label;
  final ImageProvider image;
  final bool selected;
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    selected: selected,
    label: label,
    child: GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: EdgeInsets.all(selected ? 2 : 0),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF168B7B) : const Color(0xFFF4F4F0),
          borderRadius: BorderRadius.circular(17),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image(
                image: ResizeImage(
                  image,
                  width: 400,
                  height: 400,
                  policy: ResizeImagePolicy.fit,
                ),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stack) => const ColoredBox(
                  color: Color(0xFFDDE9E4),
                  child: Icon(Icons.image_outlined),
                ),
              ),
              const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Color(0xB5002727)],
                    stops: [.28, 1],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 7, 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Text(
                          label,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            height: 1.1,
                          ),
                        ),
                      ),
                      Icon(icon, color: Colors.white, size: 19),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
