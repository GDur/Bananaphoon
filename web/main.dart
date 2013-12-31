part of bananaphoon;

void main() {
  var head = new ImageElement(src: "./images/head.png");
  var futures = [head.onLoad.first];
  
  Future.wait(futures).then((_){
    
    var paper = new Paper()
      ..addDrawable(new Image(head))
      ..autoSize();

    var camera1 = new Camera()
      ..setPaper(paper)
      ..pos.setValues(-100.0, -100.0);
    
    var camera2 = new Camera()
      ..setPaper(paper)
      ..pos.setValues(-200.0, -100.0);

    var projector1 = new Projector(camera1);
    var projector2 = new Projector(camera2, new Vector2(500.0, 300.0), new Vector2(400.0, 60.0));
  });
}
