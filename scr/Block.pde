public class Block {
  private float x, y, w, h ;
  private boolean status;
  private PImage img;


  public Block(int row, int col) {
    this.w = width /columns;
    this.h = 60;
    this.x = w * col;
    this.y = h * row;
    this.status = true;
    img = loadImage("enemy.png"); // load the image
    img.resize(width/10, height/10);
  }

  public void display() {
    fill(255, 100, 0);
    if (status == true) {
      //rect(x, y, w, h);
      image(img, x, y, w, h); // draw the image
    }
  }

  public boolean getStatus() {
    return status;
  }

  public void checkBall(Ball ball) {
    if (status == true) {
      // bottom
      if (ball.x > x && ball.x < x+w && ball.y <(y+h+ball.d/2) && ball.y>y+h) {
        ball.Vy*=-1;
        status= false;
        blockDestroyedSound.trigger();
        score++;
      }
      // top
      if (ball.x > x && ball.x < x+w && ball.y > y - ball.d/2 && ball.y < y) {
        ball.Vy*=-1;
        status= false;
        blockDestroyedSound.trigger();
        score++;
      }
      // left
      if (ball.x > x-ball.d/2 && ball.x < x && ball.y > y && ball.y < y+h) {
        ball.Vx*=-1;
        status= false;
        blockDestroyedSound.trigger();
        score++;
      }
      // right
      if (ball.x > x+w  && ball.x < x+w+ball.d/2 && ball.y > y && ball.y < y+h) {
        ball.Vx*=-1;
        status= false;
        blockDestroyedSound.trigger();
        score++;
      }
    }
  }
}
