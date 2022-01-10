//Define parameters.
int max_Hearts = 7;
int max_r = 48;
int threshold = 12;
float step = 0.5;
int canvasWidth = 600;
int canvasHeight = 600;
int _frameRate = 30;

//Define ArrayList containing 0 items of type Heart.
ArrayList<Heart> Hearts = new ArrayList<>();

//Define settings to give size parameters.
void settings() {
  size(canvasWidth, canvasHeight);
}
/*
Define setup to:
1-|Set frame rate.
2-|Give background its initial color.
3-|Set stroke to none.
4-|Populate the Hearts ArrayList with objects that have random color values and false as their isRendered attribute except the first object which has true to initiate the animation.
*/
void setup() {
  frameRate(_frameRate);
  background(0);
  noStroke();
  for(int i = 0; i < max_Hearts; i++) {
    if (i == 0) {
      Hearts.add(new Heart(0, random(1,255), random(1,255), random(1,255), true));
    } else {
      Hearts.add(new Heart(0, random(1,255), random(1,255), random(1,255), false));
    }
  }
}
/*
Define draw to:
1-|Set origin to the center of the screen
*/
void draw() {
  translate(width/2, height/2);
  for(int i = 0; i < Hearts.size(); i++) {
    if (Hearts.get(i).r >= max_r) {
      background(Hearts.get(i).clrR, Hearts.get(i).clrG,Hearts.get(i).clrB);
      Hearts.set(i, new Heart(0, random(1,255), random(1,255), random(1,255), false));
      Heart temp = Hearts.get(0);
    for(int ii = 0 ; ii < Hearts.size() - 1; ii++) {
        Hearts.set(ii, Hearts.get(ii + 1));
    }
    Hearts.set(Hearts.size() - 1, temp);
    } else if (Hearts.get(i).r >= threshold && i != Hearts.size() - 1 && !Hearts.get(i+1).isRendered) {
      Hearts.set(i+1, new Heart(0, random(1,255), random(1,255), random(1,255), true));
    } else if (Hearts.get(i).r >= threshold && i == Hearts.size() - 1 && !Hearts.get(0).isRendered) {
      Hearts.set(0, new Heart(0, random(1,255), random(1,255), random(1,255), true));
    }
    if (!Hearts.get(i).isRendered) {
      continue;
    }
    fill(Hearts.get(i).clrR, Hearts.get(i).clrG, Hearts.get(i).clrB);
    Hearts.set(i, new Heart(Hearts.get(i).r + step, Hearts.get(i).clrR, Hearts.get(i).clrG, Hearts.get(i).clrB, true));
    beginShape();
    for (float ii = 0; ii < TWO_PI; ii += 0.01) {
      vertex(Hearts.get(i).x(ii), Hearts.get(i).y(ii));
    }
    endShape();
  }
}
