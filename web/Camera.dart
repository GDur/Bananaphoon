part of bananaphoon;

class Camera {
  final Vector2 pos = new Vector2.zero();

  double zoomFactor = 1.0;
  Paper paper;

  setPaper(Paper p) {
    paper = p;
  }

  void move(Vector2 offset) {
    setPos(pos - offset);
  }

  void setPos(Vector2 offset) {
    pos.setFrom(offset);
  }

  void setRelPos(Vector2 offset) {
    pos.setFrom(offset / zoomFactor);
  }
  Vector2 getRelPos() {
    return pos * zoomFactor;
  }
}