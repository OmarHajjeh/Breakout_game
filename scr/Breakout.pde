Ball ball;
Paddle paddle;
Block[][] block;

private int rows, columns, score, lives, level;
private boolean gameComplete = false;

PImage backgroundImg;
PFont myfont;


import ddf.minim.*; // imported library for sound
Minim minim;
AudioSample blockDestroyedSound; // block destroyed sound

Minim minimm;
AudioPlayer mainSong; // main theme song

Minim minim0;
AudioSample gameOver; // game over sound effect

Minim minim1;
AudioSample hpLost; // hp lost sound effect

Minim minim2;
AudioSample gameCleared;// game cleared sound effect

Minim minim3;
AudioSample nextLevel;// next level sound effect


public void setup () {
  frameRate(160);
  //size(1920, 1080);
  size(displayWidth, displayHeight);
  fullScreen();
  smooth(8);

  backgroundImg = loadImage("space.png"); // background image

  minimm = new Minim(this); // sound
  mainSong = minimm.loadFile("mainTheme.mp3"); // main theme music

  minim = new Minim(this);
  blockDestroyedSound = minim.loadSample("invaderkilled.wav");  // block deleted sound

  minim1 = new Minim(this);
  hpLost = minim1.loadSample("hpLost.wav"); // hp lost sound effect

  minim0 = new Minim(this);
  gameOver = minim0.loadSample("gameOver.wav"); // game over sound effect

  minim2 = new Minim(this);
  gameCleared = minim2.loadSample("gameCleared.mp3");// game cleared sound effect

  minim3 = new Minim(this);
  nextLevel = minim3.loadSample("nextLevel.wav");// next level sound effect

  myfont = createFont("ARCADECLASSIC.TTF", 20, false);    // create font
  textFont(myfont);                                       // use font


  ball = new Ball();
  paddle = new Paddle();
  level = 1;
  score=0;
  lives = 3;
  rows = 4;
  columns = 4;
  makeLevel(columns, rows);
}


public void draw() {
  // Set background color
  background(0);
  image(backgroundImg, 0, 0, width, height-50);
  if (!mainSong.isPlaying()) {
    mainSong.play();                // main theme music
    mainSong.rewind();
  }

  textSize(20);
  textAlign(CENTER);
  fill(255, 0, 255);
  text("Game made by Omar  Hajjeh  and  Omar  Omar", width/2, height-20);

  // Update game objects
  ball.display();
  ball.checkPaddle(paddle);
  paddle.display();
  showBlocks();
  showLevel();
  showLives();
  showScore();
  checkWon();
  restart();

  if (level == 6) {
    gameComplete = true;
  }

  // display the game complete screen if necessary
  if (gameComplete == true) {
    gameCompleteScreen();
  }
}

public void showLevel() {
  fill(255, 0, 255);
  textSize(30);
  text("Level " + level, width - 250, height - 10);
}

public void showScore() {
  fill(255, 0, 255);
  textSize(30);
  text("Score " + score, width - 100, height - 10);
}

public void showLives() {
  fill(255, 0, 255);
  textSize(30);
  text("Lives " + lives, 60, height - 10);
}

public void restart() {
  if (lives == 0) {
    background(0);
    mainSong.close();
    showScore();
    showLevel();
    text("Click  anywhere   to  restart", 200, height-10);
    textAlign(CENTER);
    textSize(80);
    text("Game Over", width/2, height/2);
    if (mousePressed) {
      gameOver.trigger();
      setup();
      delay(3000);
    }
  }
}

public void showBlocks() {
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < columns; j++) {
      block[i][j].display();
      block[i][j].checkBall(ball);
    }
  }
}


public void makeLevel(int rows, int columns) {
  ball = new Ball();
  paddle = new Paddle();
  block = new Block[rows][columns];
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < columns; j++) {
      block[i][j] = new Block(i+3, j);
    }
  }
}


public void checkWon() {
  boolean allDestroyed = true;
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < columns; j++) {
      if (block[i][j].getStatus() == true) {
        allDestroyed = false;
        break;
      }
    }
  }
  if (allDestroyed == true) {
    newLevel();
  }
}


public void newLevel() {
  nextLevel.trigger();
  level++;
  columns++;
  rows++;
  lives++;
  makeLevel(rows, columns);
  ball.canMove=false;
  ball.x = width / 2;
  ball.y = height -75;
}


public void gameCompleteScreen() {
  mainSong.close();
  // display a black background
  background(0);
  showScore();
  text("Click  anywhere   to  exit", 200, height-10);
  // display the congratulatory message

  fill(255, 0, 255);
  textSize(50);
  textAlign(CENTER);
  text("Game Complete! Congratulations!", width/2, height/2);
}


public void mousePressed() {

  if (!ball.canMove && lives>0) {
    ball.Vy = -10;
    ball.canMove = true;
  }
  if (gameComplete) {
    gameCleared.trigger();
    delay(6000);
    exit();
  }
}
