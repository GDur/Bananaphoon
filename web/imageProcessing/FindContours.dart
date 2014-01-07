part of bananaphoon;


int width;
int height;
final int BLACK            = 1;
final int WHITE            = 0;

List<Polygon> findContours(Image image) {
  var imageData = image.getPixels().data;
  // Region LAbeling
  var labels = new List<int>(imageData.length ~/ 4);

  // 1. binary image (0=background, 1 = foreground)
  for (int i = 0; i < labels.length; i ++) {
    if (imageData[i * 4] == 0)
      labels[i] = BLACK;
    else
      labels[i] = WHITE;
  }

  var lines = new List<Polygon>();
  width = image.size.x.toInt();
  height = image.size.y.toInt();

  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {

      int i = y * width + x;
      if (labels[i] == BLACK) {
        var path = new List<Vector2>();
        path.add(new Vector2(x.toDouble(), y.toDouble()));
        path.add(new Vector2(x.toDouble(), y.toDouble() + 1));

        // 0 = down
        // 1 = left
        // 2 = up
        // 3 = right
        int directionState = 0;

        bool loopNotClosed = true;

        Vector2 last = path[path.length - 1];
        int bla = 0;
        while (loopNotClosed) {

          for (int j = 0; j < 3; j++) {

            int tmp = (directionState + 1 - j) % 4;
            if (tmp < 0)
              tmp = 4 + tmp;

            if (checkDirection(labels, last, tmp)) {
              last = move(labels, last, tmp);

              directionState = tmp;
              break;
            }
          }

          if (path.first.x == last.x && path.first.y == last.y) {
            loopNotClosed = false;
            path.add(last);
          } else
            path.add(last);
          bla++;
        }

        Vector2 a = path.first;

        // Adjust color
        // red
        String color = '#FF2400';
        // orange
        int t =  toIndex(a);
        int tt =  imageData[t * 4];
        if (tt != 0)
          color = '#ee11ee';


        int balance = 0;
        for (int j = 1; j < path.length; j++) {
          Vector2 b = path[j];
          int tmpY = b.y.toInt();
          balance = tmpY - a.y.toInt();

          if (balance > 0) {
            invertLine(labels, a);
          } else if (balance < 0) {
            invertLine(labels, b);
          }
          a = path[j];
        }
        lines.add(new Polygon.advanced(path, 3, color));
      }
    }
  }
  return lines;
}
int toIndex(Vector2 pos){
  return pos.x.toInt() + pos.y.toInt() * width;
}

bool checkDirection(List<int> labels, Vector2 pos, int direction) {

  int so = toIndex(pos);
  int nw = so - 1 - width;
  int sw = so - 1;
  int no = so - width;

  if (direction == 0)
    return (checkColor(labels, sw) != checkColor(labels, so));
  if (direction == 1)
    return (checkColor(labels, nw) != checkColor(labels, sw));
  if (direction == 2)
    return (checkColor(labels, nw) != checkColor(labels, no));
  if (direction == 3)
    return (checkColor(labels, so) != checkColor(labels, no));

  return false;
}
Vector2 move(List<int> labels, Vector2 last, int j) {
  Vector2 tmp = new Vector2.copy(last);
  if (j == 0)
    tmp.y++;
  else if (j == 1)
    tmp.x--;
  else if (j == 2)
    tmp.y--;
  else if (j == 3)
    tmp.x++;
  return tmp;
}

void invertLine(List<int> labels, Vector2 p) {
  for (int tmpX = p.x.toInt(); tmpX < width; tmpX++) {
    int tmpIndex = (p.y.toInt()) * width + tmpX;
    if (p.y < height) {
      if (labels[tmpIndex] == BLACK)
        labels[tmpIndex] = WHITE;
      else
        labels[tmpIndex] = BLACK;
    }
  }
}

int checkColor(List<int> labels, int p) {
  if (p >= width * height || p < 0)
    return WHITE;
  return labels[p];
}