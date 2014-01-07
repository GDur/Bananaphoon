part of bananaphoon;

class CatmulromPath extends ADrawable {
  Vector2 pos = new Vector2.zero();
  List<Vector2> vertices;
  String color;
  int width;

  CatmulromPath(this.vertices);

  CatmulromPath.advanced(this.vertices, this.width, this.color);

  Vector2 get(int i) {
    return vertices[i];
  }

  int length() {
    return vertices.length;
  }

  draw(CanvasRenderingContext2D ctx, Vector2 offset, double zoom){
    ctx.beginPath();
    ctx.moveTo((vertices[0].x - offset.x) * zoom,
               (vertices[0].y - offset.y) * zoom);

    for(int i = 1; i < vertices.length; i++)
      ctx.quadraticCurveTo((-offset.x + vertices[i].x) * zoom,(-offset.y + vertices[i].y) * zoom, 0, 0);

    ctx
      ..lineCap = 'square'
      ..strokeStyle = color
      ..lineWidth = width * (zoom / 13.0)
      ..stroke()
      ..closePath();
  }
}