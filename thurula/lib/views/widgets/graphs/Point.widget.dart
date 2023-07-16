class Point {
  final double x;
  final double y;

  Point({
    required this.x,
    required this.y,
  });
}

List<Point> getPoints() {
  final data = <double>[1, 2, 3, 4, 5, 6, 7, 8, 9, 10,11,13,15,17,19,21,23,25,27,29,31];
  return data.map((index) => Point(x: index, y: index*index)).toList();
}
