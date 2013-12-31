part of bananaphoon;

class Paper {
  final Vector2 size = new Vector2.zero();
  var _drawables = new List<ADrawable>();
  
  autoSize() {
    var maxSize = new Vector2.zero();
    
    _drawables.forEach((ADrawable e) {
      if(e.size != null) {
        var tmpSize = (e.size + e.pos);
        if(maxSize.x < tmpSize.x && maxSize.y < tmpSize.y) {
          maxSize = tmpSize;
        }
      }
    });
    
    setSize(maxSize);
  }
  
  setSize(Vector2 size) {
    this.size.setFrom(size);
  }

  addDrawable(ADrawable d){
    _drawables.add(d);
  }
  
  List<ADrawable> getDrawables() => _drawables;
  
  Vector2 getSize() => size;
  
}