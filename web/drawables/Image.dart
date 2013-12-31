part of bananaphoon;

class Image extends ADrawable {
  final Vector2 pos = new Vector2.zero(), size = new Vector2.zero();
  String path, name;
  ImageElement image;
  
  static int created = 0;
  
  Image(this.image,[ pos, this.name] ) { 
    if(pos != null)
      this.pos.setFrom(pos);
    
    if(name == null) {
      this.name = this.runtimeType.toString() + "_$created";
      created++;
    }
    path = image.src;
    size.setFrom(new Vector2(image.width * 1.0, image.height * 1.0));
  }
  
  draw(CanvasRenderingContext2D ctx, Vector2 offset, double zoom){
    drawImage(zoom, ctx, image, -offset.x, -offset.y);
  }
  
  ImageData getPixels(ImageElement img) {
  // Get image pixels from image element.
    var canvas = new CanvasElement(width: img.width, height: img.height);
    CanvasRenderingContext2D context = canvas.getContext('2d');
    context.drawImage(img, 0, 0);
    return context.getImageData(0, 0, canvas.width, canvas.height);
  }
  
  void drawImage(num zoom, CanvasRenderingContext2D context, ImageElement img1,ox,oy) {
  
    ImageData imgData = getPixels(img1);
  
    // Create an offscreen canvas, draw an image to it, and fetch the pixels
    CanvasElement tm = document.createElement('canvas');
    CanvasRenderingContext2D offtx = tm.getContext('2d');
  
    var d = imgData.data;
  
    // Draw the zoomed-up pixels to a different canvas context
    for (var x=0;x<img1.width; ++x){
      for (var y=0;y<img1.height; ++y){
        // Find the starting index in the one-dimensional image data
        var i = (y*img1.width + x)*4;
        var r = d[i  ];
        var g = d[i+1];
        var b = d[i+2];
        var a = d[i+3];
        context.fillStyle = "rgba($r,$g,$b,${a/255})";
        context.fillRect(((ox+x) * zoom).floor(), ((oy+y) * zoom).floor(), zoom.ceil(), zoom.ceil());
      }
    }
  }
}