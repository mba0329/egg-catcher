// SUBCLASS BadEgg
class BadEgg extends Egg {
  void display () {
    pushMatrix();
    translate(x, y);
    rotate(rotation);
    if (badEggImg != null) {
      image(badEggImg, -15, -20, 30, 40); // Draw bad egg image
    } else {
      fill(200, 50, 50);
      ellipse(0, 0, 30, 40); // Fallback if image missing
    }
    popMatrix();
  }
}
