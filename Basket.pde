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
    if (basketImg != null) {
      image(basketImg, x - w / 2, height - h, w, h); // Draw basket image
    } else {
      fill(150, 100, 50);
      rect(x - w / 2, height - h, w, h); // Fallback if image missing
    }
  }

  void move() {
    x += dir * 5;
    x = constrain(x, w / 2, width - w / 2);
  }

  void moveTo(float mx) {
    x = constrain(mx, w / 2, width - w / 2);
  }
}
