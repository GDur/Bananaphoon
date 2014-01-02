part of bananaphoon;

class Grid {
  Vector2 pos = new Vector2.zero();
   
  draw(CanvasRenderingContext2D ctx, Vector2 offset, double zoom, Vector2 size){

    ctx.lineWidth = 1.0;
    var width = ctx.canvas.width;
    var height = ctx.canvas.height;

    ctx.fillStyle = "#222222";
    ctx.fillRect(0, 0, width, height);
    
    
    // origin point
    num oX = (-offset.x * zoom).floor();
    num oY = (-offset.y * zoom).floor();

    ctx
      ..beginPath();
    
    int i = 0;
    for (var tmpX = oX; tmpX > 0; tmpX -= 10.0 * zoom) {
      
      if(i != 0){
        ctx
          ..beginPath()
          ..moveTo(tmpX.floor() , 0)
          ..lineTo(tmpX.floor(), height);

        if(i % 10 == 0)
          ctx
            ..setStrokeColorRgb(66, 66, 66)
            ..stroke()
            ..closePath();
        else
          ctx
            ..setStrokeColorRgb(44, 44, 44)
            ..stroke()
            ..closePath();
      }
      i++;
    }
    
    i = 0;
    for (var tmpX = oX; tmpX < width; tmpX += 10.0 * zoom) {
      if(i != 0){
        ctx
          ..beginPath()
          ..moveTo(tmpX.floor() , 0)
          ..lineTo(tmpX.floor(), height);
        if(i % 10 == 0)
          ctx
          ..setStrokeColorRgb(66, 66, 66)
          ..stroke()
          ..closePath();
        else
          ctx
            ..setStrokeColorRgb(44, 44, 44)
            ..stroke()
            ..closePath();
      }
      i++;
    }
    i = 0;
    for (var tmpY = oY; tmpY > 0; tmpY -= 10.0 * zoom) {
      if(i != 0){
        ctx
          ..beginPath()
          ..moveTo( 0,tmpY.floor())
          ..lineTo( width,tmpY.floor())
          ..closePath();
        if(i % 10 == 0)
          ctx
            ..setStrokeColorRgb(66, 66, 66)
            ..stroke()
            ..closePath();
        else
          ctx
            ..setStrokeColorRgb(44, 44, 44)
            ..stroke()
            ..closePath();
      }
      i++;
    }
    i = 0;
    for (var tmpY = oY; tmpY < width; tmpY += 10.0 * zoom) {

      if(i != 0){
        ctx
          ..beginPath()
          ..moveTo(0,tmpY.floor())
          ..lineTo(width,tmpY.floor());
        if(i % 10 == 0)
          ctx
            ..setStrokeColorRgb(66, 66, 66)
            ..stroke()
            ..closePath();
        else
          ctx
            ..setStrokeColorRgb(44, 44, 44)
            ..stroke()
            ..closePath();
      }
      i++;
    }

    ctx
      ..beginPath()
      ..lineWidth = 1.0
      ..setStrokeColorRgb(66, 71, 150)
      ..moveTo(oX.floor(), 0)
      ..lineTo(oX.floor(), height)
      
      ..moveTo(    0, oY.floor())
      ..lineTo(width, oY.floor())
      
      ..moveTo(oX.floor()+size.x*zoom, 0)
      ..lineTo(oX.floor()+size.x*zoom, height)
      
      ..moveTo(    0, oY.floor()+size.y*zoom)
      ..lineTo(width, oY.floor()+size.y*zoom)
      ..lineWidth = 1.0
      ..stroke()
      ..closePath();
  }
}