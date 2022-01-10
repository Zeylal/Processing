import processing.video.*;
ArrayList<Circle> circles;

int target_x = 0;
int target_y = 0;

int numPixels;
float []previousFrame;
Capture cam;
float pixAverage;

void setup(){
  size(800, 800);
  cam = new Capture(this, width, height);
  cam.start();
  numPixels = cam.width * cam.height;
  previousFrame = new float[numPixels];
  loadPixels();
  stroke(0, 255, 255);
  strokeWeight(4);
  frameRate(10);

  circles = new ArrayList<Circle>();
}

void draw() {
  updateTarget();
  drawEyes();
}

void drawTarget(int x, int y)
{
  line(x, y-15, x, y-4);
  line(x, y+15, x, y+4);
  line(x-15, y, x-4, y);
  line(x+15, y, x+4, y);
}

void updateTarget() {
  if (cam.available()) {
    cam.read();
    cam.loadPixels();
    int x = 0;
    int y = 0;
    int sum = 0;
    for (int i = 0; i < numPixels; i++) {
      float currColor = red(cam.pixels[i]);
      float prevColor = previousFrame[i];
      float d = abs(prevColor-currColor);
      if (d>50) {
        int xt = i % cam.width;
        int yt = i / cam.width;
        x += xt;
        y += yt;
        sum ++;
        pixels[i] = color(currColor, 0, 0);
      } else
        pixels[i] = color(currColor);
      previousFrame[i] = currColor;
    }
    if (sum>1000) {
      updatePixels();
      x /= sum;
      y /= sum;
      fill(0);
      rect(0, 0, width, height);
      drawTarget(x, y);
    }

    target_x = width-x;
    target_y = y;
  }
}

void drawEyes() {
  Circle newC = newCircle();

  if (newC != null) {
    circles.add(newC);
  }

  for (Circle c : circles) {
    if (c.growing) {
      if (c.edges()) {
        c.growing = false;
      } else {
        for (Circle other : circles) {
          if (c != other) {
            float d = dist(c.x, c.y, other.x, other.y);
            if (d < c.r + other.r) {
              c.growing = false;
              break;
            }
          }
        }
      }
    }

    c.show();
    c.grow();
  }
}
