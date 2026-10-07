import 'package:flutter/material.dart';

class ImageSourceDialog extends StatefulWidget {
  const ImageSourceDialog({super.key});

  @override
  State<ImageSourceDialog> createState() => _ImageSourceDialogState();
}

class _ImageSourceDialogState extends State<ImageSourceDialog> {
  final _input = TextEditingController();
  bool _network = true;
  String? _error;

  @override
  void dispose() {
    _input.dispose();
    super.dispose();
  }

  void _submit() {
    final value = _input.text.trim();
    final uri = Uri.tryParse(value);
    if (value.isEmpty ||
        (_network &&
            (uri == null || uri.scheme != 'https' || uri.host.isEmpty))) {
      setState(
        () => _error = _network
            ? 'Enter a valid HTTPS image URL.'
            : 'Enter a bundled asset path.',
      );
      return;
    }
    Navigator.of(context)
        .pop(_network ? NetworkImage(value) : AssetImage(value));
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: const Text('Make it your own'),
    content: SizedBox(
      width: 400,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'A favorite place, a favorite moment. Turn it into a little escape.',
          ),
          const SizedBox(height: 20),
          SegmentedButton<bool>(
            segments: const [
              ButtonSegment(value: true, label: Text('Image URL')),
              ButtonSegment(value: false, label: Text('Asset path')),
            ],
            selected: {_network},
            onSelectionChanged: (values) => setState(() {
              _network = values.first;
              _error = null;
              _input.clear();
            }),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _input,
            autofocus: true,
            keyboardType: _network ? TextInputType.url : TextInputType.text,
            onSubmitted: (_) => _submit(),
            decoration: InputDecoration(
              labelText: _network
                  ? 'https://…'
                  : 'assets/images/lakeside_reference.png',
              errorText: _error,
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            _network
                ? 'Use a direct HTTPS image link. Your picture is cropped to a square.'
                : 'Assets must be bundled in pubspec.yaml. The picture is cropped to a square.',
            style: const TextStyle(fontSize: 12, color: Color(0xFF74837B)),
          ),
        ],
      ),
    ),
    actions: [
      TextButton(
        onPressed: () =>
            Navigator.of(context)
                .pop(const AssetImage('assets/images/lakeside_reference.png')),
        child: const Text('Use lakeside'),
      ),
      TextButton(
        onPressed: () => Navigator.of(context).pop(),
        child: const Text('Cancel'),
      ),
      FilledButton(onPressed: _submit, child: const Text('Create puzzle')),
    ],
  );
}
