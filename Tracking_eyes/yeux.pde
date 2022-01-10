Circle newCircle() {
  float x = random(width);
  float y = random(height);

  boolean valid = true;

  // For every circle created
  for (Circle c : circles) {
    // ... check this distance against circle distance
    float d = dist(x, y, c.x, c.y);
    // ... if distance is smaller than circle radius
    if (d < c.r) {
      // ... circle not valid
      valid = false;
      break;
    }
  }
  // ... if valid
  if (valid) {
    return new Circle(x, y);
  } else {
    return null;
  }
}

class Circle {
  float x;
  float y;
  float r; // radius size

  boolean growing = true;

  Circle(float x_, float y_) {
    x = x_; // temp vars x_
    y = y_;
    r = 1;
  }

  boolean edges() {
    return (x + r > width || x - r < 0 || y + r > height || y - r < 0 );
  }

  void grow() {
    if (growing) {
      r = r + 1;
    }
  }

  void show() {  //ext

    fill(255);
    ellipse(x, y, r*2, r*2);



    noStroke();
    float pupilX = map(target_x, 0, width, -1, 1) * r/2;
    float pupilY = map(target_y, 0, height, -1, 1) * r/2;
 

    fill(#000000);
    ellipse(x+pupilX, y+pupilY, r*0.8, r*0.8);

  }
}
