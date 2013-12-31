part of bananaphoon;

class Grid {
  Vector2 pos = new Vector2.zero();
   
  draw(CanvasRenderingContext2D ctx, Vector2 offset, double zoom, Vector2 size){
    var width = ctx.canvas.width;
    var height = ctx.canvas.height;

    ctx.fillStyle = "#222222";
    ctx.fillRect(0, 0, width, height);
    
    ctx.setStrokeColorRgb(33, 33, 33);
    
    // orogin point
    num oX = (-offset.x * zoom).floor();
    num oY = (-offset.y * zoom).floor();

    ctx.lineWidth = .5;
    ctx.setStrokeColorRgb(44, 44, 44);
    
    int i = 0;
    for (var tmpX = oX; tmpX > 0; tmpX -= 10.0 * zoom) {
      if(i % 10 == 0)
        ctx.setStrokeColorRgb(66, 66, 66);
      
      if(i != 0)
        ctx
          ..beginPath()
          ..moveTo(tmpX.floor() , 0)
          ..lineTo(tmpX.floor(), height)
          ..stroke();
        
      i++;
      ctx.setStrokeColorRgb(44, 44, 44);
    }
    
    i = 0;
    for (var tmpX = oX; tmpX < width; tmpX += 10.0 * zoom) {
      if(i % 10 == 0)
        ctx.setStrokeColorRgb(66, 66, 66);   
      if(i != 0)
        ctx
          ..beginPath()
          ..moveTo(tmpX.floor() , 0)
          ..lineTo(tmpX.floor(), height)
          ..stroke();
      i++;
      ctx.setStrokeColorRgb(44, 44, 44);
    }
    i = 0;
    for (var tmpY = oY; tmpY > 0; tmpY -= 10.0 * zoom) {
      if(i % 10 == 0)
        ctx.setStrokeColorRgb(66, 66, 66);   
      
      if(i != 0)
        ctx
          ..beginPath()
          ..moveTo( 0,tmpY.floor())
          ..lineTo( width,tmpY.floor())
          ..stroke();
      i++;
      ctx.setStrokeColorRgb(44, 44, 44);
    }
    i = 0;
    for (var tmpY = oY; tmpY < width; tmpY += 10.0 * zoom) {
      if(i % 10 == 0)
        ctx.setStrokeColorRgb(66, 66, 66);   

      if(i != 0)
        ctx
          ..beginPath()
          ..moveTo(0,tmpY.floor())
          ..lineTo(width,tmpY.floor())
          ..stroke();
      i++;
      ctx.setStrokeColorRgb(44, 44, 44);
    }

    ctx.setStrokeColorRgb(66, 71, 150);
    ctx
      ..beginPath()
      ..moveTo(oX.floor(), 0)
      ..lineTo(oX.floor(), height)
      ..stroke();
    ctx
      ..beginPath()
      ..moveTo(    0, oY.floor())
      ..lineTo(width, oY.floor())
      ..stroke();
    
    ctx
      ..beginPath()
      ..moveTo(oX.floor()+size.x*zoom, 0)
      ..lineTo(oX.floor()+size.x*zoom, height)
      ..stroke();
    ctx
      ..beginPath()
      ..moveTo(    0, oY.floor()+size.y*zoom)
      ..lineTo(width, oY.floor()+size.y*zoom)
      ..stroke();
  }
}