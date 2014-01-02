part of bananaphoon;

class Polygon extends ADrawable {
  Vector2 pos = new Vector2.zero();
  
  List<Vector2> vertices;
  Polygon(this.vertices);
  
  draw(CanvasRenderingContext2D ctx, Vector2 offset, double zoom){
    ctx.beginPath();
    ctx.moveTo((vertices[0].x - offset.x) * zoom,
               (vertices[0].y - offset.y) * zoom);
    
    for(int i = 1; i < vertices.length; i++)
      ctx.lineTo((-offset.x + vertices[i].x) * zoom,(-offset.y + vertices[i].y) * zoom);
    
    ctx
      ..setStrokeColorRgb(223, 0, 227, 255)
      ..lineWidth = zoom / 4.0
      ..stroke()
      ..closePath();
  }
}