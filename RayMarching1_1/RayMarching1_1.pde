public Boundary bound1 = new Boundary(100, 200, 300, 305);
public Boundary bound2 = new Boundary(100, 200, 300, 150);
public Boundary bound3 = new Boundary(600, 150, 700, 300);
public Boundary[] bounds = new Boundary[]{bound1, bound2, bound3};


public Ray[] viewer = new Ray[595];

void setup() {
  size(800, 600);
  // Making Viewer Array
  for (int i=0; i<viewer.length; i++) {
    viewer[i] = new Ray(400, 300, i * (PI / (viewer.length / 2)), 0);
  }
}

void draw() {
  println(frameRate);
  background(0);
  fill(127);
  stroke(127);
  beginShape();
  for (int j=0; j<40; j++) {
    for (int i=0; i<viewer.length; i++) {
      // Checking for Intersections
      if (viewer[i].intersecting(bound1) || viewer[i].intersecting(bound2) || viewer[i].intersecting(bound3)) {

        // Ray will stop moving once it sees that it has intersected a line
        viewer[i].stopMarching();
      } else if (viewer[i].r * cos(viewer[i].t) + viewer[i].x > 1.5 * width || viewer[i].r * cos(viewer[i].t) + viewer[i].x < -0.5 * width || 
        viewer[i].r * sin(viewer[i].t) + viewer[i].y > 1.5 * height || viewer[i].r * sin(viewer[i].t) + viewer[i].y < -0.5 * height) {

        // Ray will stop marching if it gets too long
        viewer[i].stopMarching();
      }

      // Marching the ray
      if (viewer[i].marching) {
        Ray temp = viewer[i].move(mouseX, mouseY);
        Ray temp2 = temp.march(bounds);
        viewer[i] = temp2;
      } else {
        Ray temp = viewer[i].move(mouseX, mouseY);
        viewer[i] = temp;
      }
      strokeWeight(3);
    }
  }
  for (int i=0; i<viewer.length; i++) {

    //Displaying the endpoint of the ray (needs to be encapsulated)
    stroke(255);
    vertex(viewer[i].r * cos(viewer[i].t) + viewer[i].x, viewer[i].r * sin(viewer[i].t) + viewer[i].y);

    //Resetting each ray so that the while thing can happen again next frame
    Ray temp = viewer[i].resetR();
    temp.beginMarching();
    viewer[i] = temp;
  }
  endShape();
}