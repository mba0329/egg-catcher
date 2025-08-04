Egg[] eggs;
int numEggs = 10;
Basket basket;
boolean useMouseControl = false; // Toggle mouse/keyboard control
int score = 0;
int lives = 3;
boolean gameOver = false;

PImage bgImg; // Background image
PImage basketImg; // Basket image
PImage goodEggImg; // Good egg image
PImage badEggImg; // Bad egg image
PImage goldenEggImg; // Golden egg image

void setup() {
  size(400, 600);
  bgImg = loadImage("background-cartoon.jpg");
  basketImg = loadImage("basket-c.png");
  goodEggImg = loadImage("good-egg-c.png");
  badEggImg = loadImage("bad-egg-c.png");
  goldenEggImg = loadImage("golden-egg-c.png");
  basket = new Basket();
  eggs = new Egg[numEggs];
  for (int i = 0; i < numEggs; i++) {
    float randVal = random(1);
    if (randVal < 0.05) { // 5% chance for golden egg
      eggs[i] = new GoldenEgg();
    } else if (randVal < 0.3) { // 25% chance for bad egg (0.05 to 0.3)
      eggs[i] = new BadEgg();
    } else { // 70% chance for good egg (0.3 to 1.0)
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

  if (lives <= 0) {
    gameOver = true;
  }
  
  if (!gameOver) {
    if (useMouseControl) {
      basket.moveTo(mouseX);
    } else {
      basket.move();
    }

    for (int i = 0; i < eggs.length; i++) {
      Egg egg = eggs[i];
      egg.update();
      egg.display();

      if (egg.isCaught(basket)) {
        if (egg instanceof GoodEgg) {
          score += 10;
        } else if (egg instanceof BadEgg) {
          lives--;
        } else if (egg instanceof GoldenEgg) {
          lives++; // Add one life
        }
        // Generate new random egg type
        float randVal = random(1);
        if (randVal < 0.05) { // 5% chance for golden egg
          eggs[i] = new GoldenEgg();
        } else if (randVal < 0.3) { // 25% chance for bad egg (0.05 to 0.3)
          eggs[i] = new BadEgg();
        } else { // 70% chance for good egg (0.3 to 1.0)
          eggs[i] = new GoodEgg();
        }
      } else if (egg.y > height) {
        // Missed egg
        if (egg instanceof GoodEgg) {
          score -= 10;
        }
        
        // Generate new random egg type
        float randVal = random(1);
        if (randVal < 0.05) {
          eggs[i] = new GoldenEgg();
        } else if (randVal < 0.3) {
          eggs[i] = new BadEgg();
        } else {
          eggs[i] = new GoodEgg();
        }
      }
    }
  }

  // HUD
  // fill with text color yellow
  fill(255, 255, 0);
  textAlign(LEFT, TOP);
  textSize(18);
  text("Score: " + score, 10, 10);
  text("Lives: " + lives, 10, 30);
  textSize(14);
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
  for (int i = 0; i < eggs.length; i++) {
    // Generate new random egg type
    float randVal = random(1);
    if (randVal < 0.05) {
      eggs[i] = new GoldenEgg();
    } else if (randVal < 0.3) {
      eggs[i] = new BadEgg();
    } else {
      eggs[i] = new GoodEgg();
    }
  }
}

void restartGame() {
  score = 0;
  lives = 3;
  gameOver = false;
  resetAllEggs();
}
