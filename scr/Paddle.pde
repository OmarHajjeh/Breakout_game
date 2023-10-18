public class Paddle {
  private float x, y, w, h;

  public Paddle() {
    x = width/2;
    y = height -60;
    w = width/10;
    h = 20;
  }
  public void display() {
    fill(255, 0, 98);
    rect(x, y, w, h, 8);
    stroke(255);
    strokeWeight(3);
    this.x = mouseX - w/2;
  }
}
