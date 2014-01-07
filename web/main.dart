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

    var image = new Image(head);
    List<int> labels;
    List<int> dstPixels;

    List<Polygon> lines  = findContours(image);
    List<CatmulromPath> lines2 = getPolygons(lines);

    var paper = new Paper()
      ..addDrawable(image);

    lines.forEach((l){
      paper.addDrawable(l);
    });
    lines2.forEach((l){
      paper.addDrawable(l);
    });
    paper.autoSize();

    var camera1 = new Camera()
      ..setPaper(paper);

    var camera2 = new Camera()
      ..setPaper(paper);

    var projector1 = new Projector(camera1)
      ..zoomFitCamera(factor: 0.9)
      ..centerCamera();

    var projector2 = new Projector(camera2,
          new Vector2(160.0, 100.0),
          new Vector2(10.0, 10.0)
      )
      ..zoomFitCamera(factor: 0.9)
      ..centerCamera();

    List<Projector> projectors = [projector1, projector2];

    querySelector('body').onKeyPress.listen((event)
        => projector1.onKeyPressed(event)
    );

    querySelector('body').onMouseDown.listen((event)
        => projector1.onMouseDown(event)
    );

    querySelector('body').onMouseMove.listen((event)
        => projector1.onMouseMove(event)
    );

    querySelector('body').onMouseUp.listen((event)
        => projector1.onMouseUp(event)
    );

    querySelector('body').onMouseWheel.listen((event)
        => projector1.onMouseWheel(event)
    );

    window.onResize.listen((event)
        => projector1.onResize(event)
    );

    void draw(num _) {
      projectors.forEach((p) {
          p.draw();
      });
      window.requestAnimationFrame(draw);
    }

    void requestRedraw() {
      window.requestAnimationFrame(draw);
    }
    requestRedraw();
  });

}
