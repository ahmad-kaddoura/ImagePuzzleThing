import 'package:flutter/material.dart';

class StartPuzzleButton extends StatelessWidget {
  const StartPuzzleButton({
    super.key,
    required this.busy,
    required this.bottomInset,
    required this.onPressed,
  });
  final bool busy;
  final double bottomInset;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.fromLTRB(20, 10, 20, 12 + bottomInset),
    child: DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(
          colors: [Color(0xFF2C9585), Color(0xFF1A645A)],
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x30217E70),
            blurRadius: 16,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: SizedBox(
        width: double.infinity,
        child: FilledButton.icon(
          onPressed: busy ? null : onPressed,
          icon: busy
              ? const SizedBox.square(
                  dimension: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : const Icon(Icons.play_arrow_rounded, size: 27),
          label: Text(
            busy ? 'Opening photo…' : 'Start Puzzle',
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
          ),
          style: FilledButton.styleFrom(
            backgroundColor: Colors.transparent,
            disabledBackgroundColor: Colors.transparent,
            foregroundColor: Colors.white,
            disabledForegroundColor: Colors.white70,
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape: const StadiumBorder(),
          ),
        ),
      ),
    ),
  );
}
