part of bananaphoon;

void main() {
  var head = new ImageElement(src: "./images/head.png");
  var dartlogo = new ImageElement(src: "./images/dart-logo-small.png");
  var test3 = new ImageElement(src: "./images/test3.png");
  var w2 = new ImageElement(src: "./images/w2.png");
  var wheel = new ImageElement(src: "./images/wheel-orig2.png");
  
  var futures = [
     head.onLoad.first,
     dartlogo.onLoad.first,
     test3.onLoad.first,
     w2.onLoad.first,
     wheel.onLoad.first,
  ];
  
  Future.wait(futures).then((_){
    
    var paper = new Paper()
    ..addDrawable(new Image(wheel))
    ..addDrawable(new Image(head))
    ..addDrawable(new Image(dartlogo))
      ..autoSize();

    var camera1 = new Camera()
      ..setPaper(paper)
      ..pos.setValues(-100.0, -100.0)
      ..zoomFactor = 1.5;
    
    var camera2 = new Camera()
      ..setPaper(paper)
      ..pos.setValues(-200.0, -100.0)
      ..zoomFactor = .5;

    var projector1 = new Projector(camera1);
    
    var projector2 = new Projector(camera2, 
        new Vector2(500.0, 300.0), 
        new Vector2(700.0, 60.0)
    );
    
  });
}
