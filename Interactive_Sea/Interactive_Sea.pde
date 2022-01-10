import processing.video.*;

int target_x = 0;
int target_y = 0;
int numPixels;
float []previousFrame;
Capture cam;
float pixAverage;

boolean is_detected = false;

int ranges = 200;
float pos = 0;
void setup() {
  size(600, 600);
  //fullScreen();
  background(0);

  cam = new Capture(this, width, height);
  cam.start();
  numPixels = cam.width * cam.height;
  previousFrame = new float[numPixels];
  loadPixels();
  stroke(0, 255, 255);
  strokeWeight(4);
  frameRate(10);
}
float speed;
void draw() {
  
  updateTarget();
  background(0);
  noFill();
  stroke(0);
  strokeWeight(1);
  target_x = constrain(target_x, 0, width);
  //if (is_detected) {
    /*
    if (target_x < 200){
      speed = 0;
    }else {
      speed = 0.05;
    }*/
    println(target_x,speed);
    speed = map(target_x, 0, width, 0.001, 0.01);
  //}
  pos += speed;

  for (int i = 0; i < ranges; i++) {
    float paint = map(i, 0, ranges, 0, 255);
    stroke(#2B29E3);

    beginShape();
    for (int x = -10; x < width + 11; x += 20) {
      float n = noise(x * 0.001, i * 0.01, pos);
      float y = map(n, 0, 1, 10, height);
      vertex(x, y);
    }
    endShape();
  }
  ellipse(target_x, target_y, 50, 50);
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
      is_detected = true;
    } else {
      is_detected = false;
    }

    target_x = width-x;
    target_y = y;
  }
}
