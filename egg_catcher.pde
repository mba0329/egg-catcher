Egg[] eggs;
int numEggs = 10;
Basket basket;
boolean useMouseControl = false; // Toggle mouse/keyboard control
int score = 0;
int lives = 100;
boolean gameOver = false;

PImage bgImg; // Background image

void setup() {
  size(400, 600);
  bgImg = loadImage("background.jpg");
  basket = new Basket();
  eggs = new Egg[numEggs];
  for (int i = 0; i < numEggs; i++) {
    if (random(1) < 0.3) {
      eggs[i] = new BadEgg();
    } else {
      eggs[i] = new GoodEgg();
    }
  }
}

void draw() {
  if (bgImg != null) {
    image(bgImg, 0, 0, width, height); // Draw background image
  } else {
    background(200, 220, 255); // Fallback if image missing
  }

  basket.display();

  if (!gameOver) {
    if (useMouseControl) {
      basket.moveTo(mouseX);
    } else {
      basket.move();
    }

    for (Egg egg : eggs) {
      egg.update();
      egg.display();

      if (egg.isCaught(basket)) {
        if (egg instanceof GoodEgg) {
          score += 10;
        } else if (egg instanceof BadEgg) {
          lives--;
          if (lives <= 0) {
            gameOver = true;
          }
        }
        egg.reset();
      } else if (egg.y > height) {
        // Missed egg
        if (egg instanceof GoodEgg) {
          lives--;
          if (lives <= 0) {
            gameOver = true;
          }
        }
        egg.reset();
      }
    }
  }

  // HUD
  fill(255);
  textAlign(LEFT, TOP);
  textSize(14);
  text("Score: " + score, 10, 10);
  text("Lives: " + lives, 10, 30);
  text("Controls: Arrow keys or press 'M' for mouse control\nClick or Spacebar to reset eggs", 10, 50);

  if (gameOver) {
    fill(255, 0, 0);
    textAlign(CENTER, CENTER);
    textSize(40);
    text("GAME OVER", width / 2, height / 2 - 30);
    textSize(20);
    text("Final Score: " + score, width / 2, height / 2 + 10);
    text("Press R to Restart", width / 2, height / 2 + 40);
    textSize(12);
  }
}

void keyPressed() {
  if (!useMouseControl && !gameOver) {
    if (keyCode == LEFT) basket.dir = -1;
    if (keyCode == RIGHT) basket.dir = 1;
  }
  if (key == 'm' || key == 'M') useMouseControl = !useMouseControl;
  if (key == ' ') resetAllEggs();
  if (key == 'r' || key == 'R') restartGame();
}

void keyReleased() {
  if (!useMouseControl && !gameOver) {
    if (keyCode == LEFT || keyCode == RIGHT) basket.dir = 0;
  }
}

void mouseMoved() {
  if (useMouseControl && !gameOver) {
    basket.moveTo(mouseX);
  }
}

void mouseDragged() {
  if (useMouseControl && !gameOver) {
    basket.moveTo(mouseX);
  }
}

void mouseClicked() {
  if (!gameOver) resetAllEggs();
}

void resetAllEggs() {
  for (Egg egg : eggs) {
    egg.reset();
  }
}

void restartGame() {
  score = 0;
  lives = 100;
  gameOver = false;
  resetAllEggs();
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
    // You can replace this with an image for a more appealing basket.
    fill(160, 90, 0);
    rectMode(CENTER);
    rect(x, height - h, w, h);
  }

  void move() {
    x += dir * 5;
    x = constrain(x, w / 2, width - w / 2);
  }

  void moveTo(float mx) {
    x = constrain(mx, w / 2, width - w / 2);
  }
}

// CLASS: EGG
abstract class Egg {
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

  abstract void display();

  boolean isCaught(Basket b) {
    return y > height - b.h && abs(x - b.x) < b.w / 2;
  }
}

// SUBCLASS GoodEgg
class GoodEgg extends Egg {
  void display () {
    fill(255, 255, 180);
    ellipse(x, y, 30, 40);
  }
}

// SUBCLASS BadEgg
class BadEgg extends Egg {
  void display () {
    fill(200, 50, 50);
    ellipse(x, y, 30, 40);
  }
}
