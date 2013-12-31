part of bananaphoon;



void main() {
  var head = new ImageElement(src: "./images/head.png");
  var futures = [head.onLoad.first];
  Future.wait(futures).then((_){
    
    var paper = new Paper()
      ..addDrawable(new Image(head))
      ..autoSize();

    var camera = new Camera()
    ..setPaper(paper);
  });
}
