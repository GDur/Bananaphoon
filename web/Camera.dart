part of bananaphoon;

class Camera {
  final pos = new Vector2.zero();

  double zoomFactor = 1.0;
  Paper paper;
  
  setPaper(Paper p){
    paper = p;
  }
  
}