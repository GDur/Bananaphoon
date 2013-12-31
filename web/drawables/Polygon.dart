part of bananaphoon;

class Polygon extends ADrawable {
  Vector2 pos = new Vector2.zero();
  
  List<Vector2> vertices;
  Polygon(this.vertices);
  
  draw(CanvasRenderingContext2D ctx, Vector2 offset, double zoom){
    ctx.setStrokeColorRgb(20, 40, 200, 255); 
    ctx.lineWidth = zoom / 4.0;
    ctx.moveTo((vertices[0].x-offset.x) * zoom,(vertices[0].y-offset.y) * zoom);
    for(int i = 1; i < vertices.length; i++)
      ctx.lineTo((-offset.x + vertices[i].x) * zoom,(-offset.y + vertices[i].y) * zoom);
    ctx.stroke();
  }
}