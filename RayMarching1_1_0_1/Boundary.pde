class Boundary{
  public float x1;
  public float y1;
  public float x2;
  public float y2;
  public Boundary(float x1_, float y1_, float x2_, float y2_) {
    x1 = x1_;
    y1 = y1_;
    x2 = x2_;
    y2 = y2_;
  }
  
  public PVector[] getPoints(int numPoints) {
    PVector[] points = new PVector[numPoints];
    float pointXStep = ((x2 - x1) / numPoints);
    float pointYStep = ((y2 - y1) / numPoints);
    for (int i=0; i<points.length; i++) {
      points[i] = new PVector((pointXStep * i) + x1, (pointYStep * i) + y1);
    }
    return points;
  }
  
  public float[] inOrder() {
    if (x1 < x2) {
      float[] ret = new float[]{x1, x2};
      return ret;
    } else {
      float[] ret = new float[]{x2, x1};
      return ret;
    }
  }
  
  public void show() {
    stroke(255);
    line(x1, y1, x2, y2);
  }
}