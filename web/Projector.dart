part of bananaphoon;

class Projector {

  CanvasElement canvas;
  CanvasRenderingContext2D ctx;

  Camera camera;
  DivElement div;

  Grid grid;
  bool isFullscreen = false;
  Vector2 pos;
  Vector2 mPos = new Vector2.zero();
  Vector2 lastMousePosition = new Vector2.zero();

  bool isDown = false;
  Projector(this.camera, [ Vector2 size, Vector2 pos]) {
    canvas = new CanvasElement();

    ctx = canvas.getContext('2d');

    div = new DivElement();
    div.style.position = "absolute";


    if(size != null){
      setSize(size);
      div.style.border = "1px solid #B3B2B2";
    }
    else
      isFullscreen = true;

    div.children.add(canvas);
    if(pos != null){
      setPos(pos);
    }
    querySelector("body").children.add(div);

    grid = new Grid();
    draw();
  }

  zoomFitCamera({num factor: 1.0}) {
    double w, h;
    if(isFullscreen){
      w = window.innerWidth.toDouble() / camera.paper.getSize().x;
      h = window.innerHeight.toDouble() / camera.paper.getSize().y;
    }else{
      w = getSize().x.toDouble() / camera.paper.getSize().x;
      h = getSize().y.toDouble() / camera.paper.getSize().y;
    }

    camera.zoomFactor = factor * Math.min(w, h);
  }

  void onKeyPressed(KeyboardEvent e) {
    print(e.keyCode);
  }

  Vector2 getMousePos(MouseEvent e) {
    double a = e.client.x * 1.0;
    double b = e.client.y * 1.0;
    return new Vector2(a, b);
  }

  void onMouseWheel(WheelEvent e) {
    Vector2 mpos = getMousePos(e);
    var a = (mpos + camera.getRelPos()) / camera.zoomFactor;

    if(e.deltaY < 0)
      camera.zoomFactor *= 1.1;
    else
      camera.zoomFactor /= 1.1;

    var newPos = (a * camera.zoomFactor) - getMousePos(e);
    camera.setRelPos(newPos);
  }

  void onMouseDown(MouseEvent e) {
    isDown = true;
    lastMousePosition.setFrom(getMousePos(e));
  }

  void onMouseMove(MouseEvent e) {
    if(isDown) {
      Vector2 offset = lastMousePosition - getMousePos(e);
      camera.setPos(camera.pos + offset / camera.zoomFactor);
      lastMousePosition.setFrom(getMousePos(e));
    }
  }

  void onMouseUp(MouseEvent e) {
    isDown = false;
  }

  void centerCamera() {
   double a, b;
   if(isFullscreen){
     a = window.innerWidth.toDouble() - camera.paper.getSize().x * camera.zoomFactor;
     b = window.innerHeight.toDouble() - camera.paper.getSize().y * camera.zoomFactor;
     camera.pos.setFrom(new Vector2(-a / (2*camera.zoomFactor), -b / (2*camera.zoomFactor)));
   }else{
     a = getSize().x - camera.paper.getSize().x * camera.zoomFactor;
     b = getSize().y - camera.paper.getSize().y * camera.zoomFactor;
     camera.pos.setFrom(new Vector2(-a / (2*camera.zoomFactor), -b / (2*camera.zoomFactor)));
   }
  }

  void draw() {
    if(isFullscreen)
      setSize(new Vector2(window.innerWidth.toDouble(), window.innerHeight.toDouble()));

    grid.draw(ctx, camera.pos, camera.zoomFactor, camera.paper._size);

    camera.paper.getDrawables().forEach((e){
      e.draw(ctx, camera.pos, camera.zoomFactor);
    });
  }

  void setSize(Vector2 size) {
    canvas.width  = size.x.toInt();
    canvas.height = size.y.toInt();
  }

  void setPos(Vector2 pos) {
    div.style.left = pos.x.toInt().toString() + "px";
    div.style.top  = pos.y.toInt().toString() + "px";
  }

  Vector2 getPos(){
    return pos;
  }

  Vector2 getSize() {
    return new Vector2(canvas.width.toDouble(), canvas.height.toDouble());
  }
}