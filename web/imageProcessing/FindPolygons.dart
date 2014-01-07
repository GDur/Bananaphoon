part of bananaphoon;

List<CatmulromPath> getPolygons(List<Polygon> lines) {

  var optimalPolygons = new List<CatmulromPath>();

    // for all out- and inlines
  lines.forEach((line) {

    List<int> pivots = new List<int>(line.length());
    // search straight pathes
    for (int i = 0; i < line.length(); i++) {
      // Notiere pivot[i] = k als ersten Index, der den straight path
      // beendet.
      pivots[i] = searchMaxStraightPath(line, i);
    }

    print((pivots));
    // Erlaubtes Segment (possible segment)
    pivots = findPossibleSegments(pivots);
    print((pivots));

    // Finde optimales Polygon
    List<Vector2> optimalPolygon = findOptimalPolygon(pivots, line.vertices);

    // Adjust color // red - outline
    String type = 'orange';
    // orange - inline
    if (line.color == 0xffFF6103)
      type = 'blue';

    optimalPolygons.add(new CatmulromPath.advanced(optimalPolygon, 2, type));
  });

  return optimalPolygons;
}

List<int> findPossibleSegments(List<int> straightPaths) {
  // mit freundlicher unterst�tzung von von christoph
  int len = straightPaths.length;
  List<int> possibleSegments = new List<int>(len);
  for (int i = 0; i < len; ++i) {
    possibleSegments[(i + 1) % len] = (straightPaths[i] - 1 + len) % len;
  }
  return possibleSegments;
}

List<Vector2> findOptimalPolygon(List<int> pivots, List<Vector2> points) {

  int lowestCount = 999999;//Integer.MAX_VALUE;

  var optimalPolygonIndexes = new List<int>();

  for (int startIndex = 0; startIndex < pivots.length; startIndex++) {
    bool b = false;
    int a = startIndex;
    int v = startIndex - 1;
    List<int> tmpIndexList = new List<int>();

    tmpIndexList.add(startIndex);

    if (startIndex == 20){
      print("important $startIndex");
    }

    int test = pivots[startIndex];

    while (true) {

      if (a < v)
        b = true;
      if (b && a >= startIndex) {
        tmpIndexList.add(startIndex);
        break;
      }
      v = a;
      a = pivots[a];
      tmpIndexList.add(a);
      if(tmpIndexList.length > lowestCount)
        break;
    }
    if (tmpIndexList.length < lowestCount) {
      lowestCount = tmpIndexList.length;
      optimalPolygonIndexes = tmpIndexList;
    }
  }

  var optimalPolygon = new List<Vector2>();
  for (int i = 0; i < optimalPolygonIndexes.length; i++) {
    optimalPolygon.add(points[optimalPolygonIndexes[i]]);
  }

  return optimalPolygon;
}



int searchMaxStraightPath(Polygon line, int i) {
  // 1. Sei i ein fester Startpunkt -> siehe signatur

  // 2. Seien c0 und c1 zwei mit (0,0)
  // initialisierte Vektoren (constraints)

  Vector2 c_0 = new Vector2.zero();
  Vector2 c_1 = new Vector2.zero();

  Vector2 v_i = line.get(i);

  // tmp variables for direction check
  Vector2 lastV_k = new Vector2.copy(v_i);
  List<bool> directions = new List(4);
  directions.fillRange(0, 4, false);
  int k = (i + 1) % line.length();
  // F�r k = i +1, i +2,
  while (true) {

    // if (i >= line.length)
    // break;

    Vector2 v_k = line.get(k);

    // Falls mehr als 3 Richtungen -> Abbruch
    if (usedMoreThan3Directions(v_k, lastV_k, directions)) {
      // abbruch
      break;
    }

    // Berechne den Vektor v_i - v_k = tmpVec
    Vector2 tmpVec = v_i - v_k;

    // Falls tmpVec den constraint verletzt -> abbruch
    if (c_0.cross(tmpVec) < 0 || c_1.cross(tmpVec) > 0) {
      // abbruch
      break;
    }

    // Aktualisiere den constraint
    updateConstraints(tmpVec, c_0, c_1);

    lastV_k = new Vector2.copy(v_k);
    k = (k + 1) % line.length();
  }
  // Notiere pivot[i] = k als ersten Index, der den straight path beendet.

  // in this case just return k and insert it in in pivot array afterwards
  return (k - 1) % line.length();
}

// Constaint aktualisieren
void updateConstraints(Vector2 a, Vector2 c_0, Vector2 c_1) {
  // Sei a = v_i - v_k

  // if not following condition then: berechne c0 und c1 neu
  if (!(a.x.abs() <= 1 && a.y.abs() <= 1)) {
    Vector2 d = new Vector2.zero();

    // Constaint aktualisieren: c0
    if (a.y >= 0 && (a.y > 0 || a.x < 0))
      d.x = a.x + 1;
    else
      d.x = a.x - 1;

    if (a.x <= 0 && (a.x < 0 || a.y < 0))
      d.y = a.y + 1;
    else
      d.y = a.y - 1;

    if (c_0.cross(d) >= 0)
      c_0.setFrom(d);

    // Constaint aktualisieren: c1
    if (a.y <= 0 && (a.y < 0 || a.x < 0))
      d.x = a.x + 1;
    else
      d.x = a.x - 1;

    if (a.x >= 0 && (a.x > 0 || a.y < 0))
      d.y = a.y + 1;
    else
      d.y = a.y - 1;

    if (c_1.cross(d) <= 0)
      c_1.setFrom(d);
  }
}

bool usedMoreThan3Directions(Vector2 a, Vector2 b, List<bool> directions) {

  if (a.x < b.x)
    directions[0] = true;
  if (a.x > b.x)
    directions[1] = true;
  if (a.y < b.y)
    directions[2] = true;
  if (a.y > b.y)
    directions[3] = true;

  int sum = 0;

  for (int i = 0; i < directions.length; i++) {
    if (directions[i])
      sum++;
  }

  if (sum > 3)
    return true;

  return false;
}