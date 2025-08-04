// SUBCLASS GoldenEgg
class GoldenEgg extends Egg {
  void display () {
    pushMatrix();
    translate(x, y);
    rotate(rotation);
    if (goldenEggImg != null) {
      image(goldenEggImg, -15, -20, 30, 40); // Draw golden egg image
    } else {
      fill(255, 215, 0); // Gold color fallback
      ellipse(0, 0, 30, 40); // Fallback if image missing
    }
    popMatrix();
  }
}
