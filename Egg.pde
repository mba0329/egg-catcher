// CLASS: EGG
abstract class Egg {
  float x, y;
  float speed = random(3,6);
  float rotation = 0;
  float rotationSpeed = random(-0.1, 0.1);

  Egg() {
    reset();
  }

  void reset() {
    x = random(20, width - 20);
    y = random(-200, -50);
    rotation = 0;
    rotationSpeed = random(-0.1, 0.1);
  }

  void update() {
    y += speed;
    rotation += rotationSpeed;
  }

  abstract void display();

  boolean isCaught(Basket b) {
    return y > height - b.h && abs(x - b.x) < b.w / 2;
  }
}
