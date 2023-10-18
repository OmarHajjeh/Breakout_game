public class Ball {

  private float x, y, Vx, Vy, d;
  private boolean canMove ;


  public Ball() {
    x = width / 2;
    y = height - 75;
    d = height/50;
    Vx = 0;
    Vy = -10;
    canMove = false;
  }

  public void display() {
    fill (0, 245, 255);
    circle(x, y, d);
    if (canMove) {

      x += Vx;
      y += Vy;

      if (x > width -5 || x < 5) {
        Vx *= -1;
      }
      if (y <5) {
        Vy *= -1;
      } else if (y> height - d) {
        canMove = false;
        y = height - 75;
        lives--;
        hpLost.trigger();
      }
    } else {
      x = mouseX;
    }
  }

  public void checkPaddle(Paddle pad) {
    if ( x > pad.x  && x < pad.x + pad.w && y > pad.y-d/2 && y < pad.y+d) {
      Vy *= -2;
      Vx += (x - mouseX)/10;
    }
    if (Vx >20) {
      Vx=20;
    }
    if (Vx <-20) {
      Vx=-20;
    }
    if (Vy >20) {
      Vy=20;
    }
    if (Vy<-20) {
      Vy=-20;
    }
  }
}
