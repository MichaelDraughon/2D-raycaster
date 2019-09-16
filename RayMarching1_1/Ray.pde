class Ray {
  public float x;
  public float y;
  public float t;
  public float r;
  public boolean marching;
  public Ray(float x_, float y_, float t_, float r_) {
    x = x_;
    y = y_;
    t = t_;
    r = r_;
    marching = true;
  }

  public void stopMarching() {
    marching = false;
  }

  public void beginMarching() {
    marching = true;
  }

  public Ray resetR() {
    return new Ray(x, y, t, 0);
  }

  public Ray march(float n) {
    return new Ray(x, y, t, r + n);
  }

  // FINALLY, IT WORKS
  public Ray march(Boundary[] b) {

    //set the distance as the max value of a float
    float minDiff = MAX_FLOAT;

    //iterating through the array of boundaries
    for (int i=0; i<b.length; i++) {
      PVector[] points = b[i].getPoints(45);

      //iterating through the points in the boundaries
      for (int j=0; j<points.length; j++) {
        if (sqrt(pow(points[j].x - (r * cos(t) + x), 2) + pow(points[j].y - (r * sin(t) + y), 2)) < minDiff) {
          minDiff = sqrt(pow(points[j].x - (r * cos(t) + x), 2) + pow(points[j].y - (r * sin(t) + y), 2));
        }
      }
    }
    return march(minDiff);
  }

  public Ray move(float newX, float newY) {
    return new Ray(newX, newY, t, r);
  }

  public void show() {
    line(x, y, r * cos(t) + x, r * sin(t) + y);
  }

  public boolean intersecting(Boundary b) {
    if (b.x1 == b.x2 || b.y1 == b.y2) {
      return true;
    } else {

      // Setting up Variables
      float x3 = x;
      float y3 = y;
      float x4 = r * cos(t) + x3;
      float y4 = r * sin(t) + y3;
      float boundarySlope = (b.y2 - b.y1) / (b.x2 - b.x1);
      float raySlope = (y4 - y3) / (x4 - x3);
      float boundaryYIntercept;
      float rayYIntercept;

      if (t > PI / 2 && t < (3 * PI) / 2) {
        // Finding Y intercept for Boundary Right hand side ONLY
        if (b.x1 < b.x2) {
          boundaryYIntercept = b.y1 - (boundarySlope * b.x1);
        } else {
          boundaryYIntercept = b.y2 - (boundarySlope * b.x2);
        }

        // Finding Y intercept for Ray
        if (x3 < x4) {
          rayYIntercept = y3 - (raySlope * x3);
        } else {
          rayYIntercept = y4 - (raySlope * x4);
        }
        // Calculating the X value for which the two lines are equal
        float xIntersection = (rayYIntercept - boundaryYIntercept) / (boundarySlope - raySlope);

        // Seeing if the Intersection is on the segment or not
        float[] order = b.inOrder();
        if (xIntersection > order[0] && xIntersection < order[1] && x4 < xIntersection && x3 > xIntersection) {
          return true;
        } else {
          return false;
        }
      } else {
        // Finding Y intercept for Boundary left hand side ONLY
        if (b.x1 > b.x2) {
          boundaryYIntercept = b.y1 - (boundarySlope * b.x1);
        } else {
          boundaryYIntercept = b.y2 - (boundarySlope * b.x2);
        }

        // Finding Y intercept for Ray
        if (x3 > x4) {
          rayYIntercept = y3 - (raySlope * x3);
        } else {
          rayYIntercept = y4 - (raySlope * x4);
        }

        // Calculating the X value for which the two lines are equal
        float xIntersection = (rayYIntercept - boundaryYIntercept) / (boundarySlope - raySlope);

        // Seeing if the Intersection is on the segment or not
        float[] order = b.inOrder();
        if (xIntersection > order[0] && xIntersection < order[1] && x4 > xIntersection && x3 < xIntersection) {
          return true;
        } else {
          return false;
        }
      }
    }
  }
}