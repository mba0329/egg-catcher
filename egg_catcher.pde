Egg[] eggs;
int numEggs = 10;

Basket basket;

void setup() {
  size(400, 600);
  basket = new Basket();
  eggs = new Egg[numEggs];
  for (int i = 0; i < numEggs; i++) {
    eggs[i] = new Egg();
  }
}

void draw() {
  background(200, 220, 255);

  basket.display();
  basket.move();

  for (Egg egg : eggs) {
    egg.update();
    egg.display();

    if (egg.isCaught(basket)) {
      egg.reset();
    } else if (egg.y > height) {
      egg.reset();
    }
  }
}

void keyPressed() {
  if (keyCode == LEFT) basket.dir = -1;
  if (keyCode == RIGHT) basket.dir = 1;
}

void keyReleased() {
  if (keyCode == LEFT || keyCode == RIGHT) basket.dir = 0;
}

// CLASS: BASKET
class Basket {
  float x;
  float w = 80;
  float h = 40;
  int dir = 0;

  Basket() {
    x = width / 2;
  }

  void display() {
    fill(160, 90, 0);
    rectMode(CENTER);
    rect(x, height - h, w, h);
  }

  void move() {
    x += dir * 5;
    x = constrain(x, w / 2, width - w / 2);
  }
}

// CLASS: EGG
class Egg {
  float x, y;
  float speed = 3;

  Egg() {
    reset();
  }

  void reset() {
    x = random(20, width - 20);
    y = random(-200, -50);
  }

  void update() {
    y += speed;
  }

  void display() {
    fill(255, 255, 180);
    ellipse(x, y, 30, 40);
  }

  boolean isCaught(Basket b) {
    return y > height - b.h && abs(x - b.x) < b.w / 2;
  }
}
