part of bananaphoon;

abstract class ADrawable {
  Vector2 pos, size;
  draw(CanvasRenderingContext2D ctx, Vector2 offset, double zoom);
}