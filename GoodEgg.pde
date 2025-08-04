// SUBCLASS GoodEgg
class GoodEgg extends Egg {
  void display () {
    pushMatrix();
    translate(x, y);
    rotate(rotation);
    if (goodEggImg != null) {
      image(goodEggImg, -15, -20, 30, 40); // Draw good egg image
    } else {
      fill(255, 255, 180);
      ellipse(0, 0, 30, 40); // Fallback if image missing
    }
    popMatrix();
  }
}
