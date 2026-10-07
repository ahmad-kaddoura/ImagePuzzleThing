enum PuzzleLayout {
  jigsaw('Jigsaw', 'Curves & connections'),
  mosaic('Mosaic', 'Clean little squares'),
  triangles('Prism', 'A different angle');

  const PuzzleLayout(this.label, this.description);

  final String label;
  final String description;

  int pieceCount(int dimension) =>
      dimension * dimension * (this == triangles ? 2 : 1);
  int cellIndex(int piece) => this == triangles ? piece ~/ 2 : piece;
}
