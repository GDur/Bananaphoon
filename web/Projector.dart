part of bananaphoon;

class Projector {
  CanvasElement canvas;
  CanvasRenderingContext2D ctx;
  Camera camera;
  DivElement div;
  
  Grid grid;
  Projector(this.camera, [ Vector2 size, Vector2 pos]) {
    canvas = new CanvasElement();
    
    ctx = canvas.getContext('2d');
    
    div = new DivElement();
    div.style.position = "relative";
    div.children.add(canvas);
    
    if(size != null)
      setSize(size);
    
    
    if(pos != null)
      setPos(pos);
    

    querySelector("body").children.add(div);

    grid = new Grid();
    
    grid.draw(ctx, camera.pos, camera.zoomFactor, camera.paper.size);

    camera.paper.getDrawables().forEach((e){
      e.draw(ctx, camera.pos, camera.zoomFactor);
    });
  }

  setSize(Vector2 size) {
    canvas.width  = size.x.toInt();  
    canvas.height = size.y.toInt();  
  }
  
  setPos(Vector2 pos) {
    div.style.left = pos.x.toInt().toString() + "px";  
    div.style.top = pos.y.toInt().toString() + "px";   
  }
  
  getSize() {
    return new Vector2(canvas.height.toDouble(), canvas.width.toDouble());
  }
}