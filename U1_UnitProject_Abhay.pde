import damkjer.ocd.*;

Camera cam;
Camera staticCam;

float range = 10000;

float[] target;
float[] camPos;

ArrayList<Bullet> b = new ArrayList<Bullet>();
ArrayList<MovingEnemy> mE = new ArrayList<MovingEnemy>();
ArrayList<ShootingEnemy> sE = new ArrayList<ShootingEnemy>();

PVector bulletTarget;

PVector spawn;

Player player;

float health = 100;
float score = 0;

int bulletsShot = 0;
int enemiesKilled = 0;

int shootingKilled = 0;
int movingKilled = 0;

int screenState = 0;

void setup()
{
  fullScreen(P3D);
  noStroke();
  rectMode(CENTER);

  noCursor();

  PVector playerSpawn = new PVector(0, height/2, 0);

  player = new Player(playerSpawn);

  cam = new Camera(this, player.pos.x, player.pos.y, player.pos.z, player.pos.x, player.pos.y, -range);
  staticCam = new Camera(this, width/2, height/2, 1000, width/2, height/2, 0);

  textAlign(CENTER);
}

void draw()
{
  background(0);

  switch(screenState)
  {
  case 0:

    staticCam.feed();

    cursor();

    textSize(108);
    text("Block Game", width/2, height/10);

    textSize(64);
    text("A survival FPS (with blocks)", width/2, height - (height/10));

    button(width/2 - 50, height/2, 120, 1, "Play");

    break;

  case 1:

    noCursor();

    target = cam.target();
    camPos = cam.position();

    cam.feed();
    mouseLook();

    player.pos.x = camPos[0];
    player.pos.y = camPos[1];
    player.pos.z = camPos[2];

    bulletTarget = new PVector(target[0], target[1], target[2]);

    if (mE.size() <= 5 + (int) (movingKilled/15))
    {
      int spawnPlace = (int) random(3);

      switch(spawnPlace)
      {
      case 0:
        spawn = new PVector(random(-width, width), random(height), -range + 100);
        mE.add(new MovingEnemy(spawn, player.pos, random(5, 10), random(50, 200), 0));
        break;

      case 1:
        spawn = new PVector(-width + 100, random(height), random(-range, -range/2));
        mE.add(new MovingEnemy(spawn, player.pos, random(5, 10), random(50, 200), 0));
        break;

      case 2:
        spawn = new PVector(width - 100, random(height), random(-range, -range/2));
        mE.add(new MovingEnemy(spawn, player.pos, random(5, 10), random(50, 200), 0));
        break;
      }
    }

    if (sE.size() <= 2)
    {
      int spawnPlace = (int) random(3);

      switch(spawnPlace)
      {
      case 0:
        spawn = new PVector(random(-width, width), random(height), -range + 100);
        sE.add(new ShootingEnemy(spawn, random(50, 200), 0, random(4000, 8000)));
        break;

      case 1:
        spawn = new PVector(-width, random(height), random(-range, 0));
        sE.add(new ShootingEnemy(spawn, random(50, 200), 0, random(4000, 8000)));
        break;

      case 2:
        spawn = new PVector(width, random(height), random(-range, 0));
        sE.add(new ShootingEnemy(spawn, random(50, 200), 0, random(4000, 8000)));
        break;
      }
    }

    pushMatrix();
    translate(0, height/2, -range/2);
    noFill();
    stroke(255);
    box(width*2, height, range);
    popMatrix();

    for (int i = 0; i < b.size(); i++)
    {
      b.get(i).update(); 

      if (b.get(i).pos.x < -width || b.get(i).pos.x > width || b.get(i).pos.y < 0 || b.get(i).pos.y > height || b.get(i).pos.z < -range || b.get(i).pos.z > 0)
      {
        b.remove(i);
      }
    }

    for (int i = 0; i < mE.size(); i++)
    {
      mE.get(i).display();
      mE.get(i).move();
      mE.get(i).checkIfShot();
      mE.get(i).checkCollision();

      if (mE.get(i).pos.x < -width || mE.get(i).pos.x > width || mE.get(i).pos.z > 0 || mE.get(i).pos.z < -range || mE.get(i).pos.y < 0 || mE.get(i).pos.y > height)
      {
        mE.remove(i);
      }

      if (mE.get(i).killed)
      {
        mE.remove(i);
        score += 6;
        health++;
        enemiesKilled++;
        movingKilled++;
      }
    }

    for (int i = 0; i < sE.size(); i++)
    {
      sE.get(i).update(); 
      sE.get(i).shoot(sE.get(i).pos, player.pos);

      if (sE.get(i).killed)
      {
        sE.remove(i);
        score += 8;
        health++;
        enemiesKilled++;
        shootingKilled++;
      }
    }

    noStroke();
    fill(255, 0, 0);
    pushMatrix();
    translate(target[0], target[1], target[2]);
    sphere(30);
    strokeWeight(5);
    stroke(0, 255, 0);
    noFill();
    arc(0, 0, 300, 300, 0, radians(health*3.6));
    fill(255);
    textSize(200);
    text((int) score, - width/2 + 200, - height/2 + 100);
    popMatrix();

    strokeWeight(1);
    noStroke();
    fill(255);

    health += 0.025;

    if (health >= 100)
    {
      health = 100;
    }

    if (health <= 0)
    {
      screenState = 2;
    }

    break;

  case 2:

    staticCam.feed();

    textSize(128);
    text("Game Over", width/2, 200);

    textSize(64);
    text("Press ESC to return to start", width/2, 300);

    textSize(36);

    text("Score: " + (int) score, width/3, 600);
    text("Bulllets Fired: " + bulletsShot, width/3, 700);

    text("Enemies Killed: " + enemiesKilled, 2*width/3, 550);
    text("Shooting Enemies Killed: " + shootingKilled, 2*width/3 + 50, 650);
    text("Moving Enemies Killed: " + movingKilled, 2*width/3 + 50, 750);

    break;
  }
}

void mousePressed()
{
  if (screenState == 1)
  {
    b.add(new Bullet(player.pos, bulletTarget, 100));
    score -= 3;
    bulletsShot++;
  }
}

void keyPressed()
{
  if (screenState != 0)
  {
    if (key == ESC)
    {
      key = 0;

      screenState = 0;
    }
  }
}

void button(float x1, float y1, int buttonHeight, int number, String buttonText)
{
  float buttonWidth = buttonText.length() * 13 * 1.5384615385 * 3;
  fill(255, 0);
  stroke(255, 0);
  rect(x1, y1, buttonWidth, buttonHeight);
  fill(255);
  textSize(90);
  text(buttonText, x1, y1);

  if (mouseX>=(x1-(buttonWidth/2))&&mouseY>=(y1-(buttonHeight/2))&&mouseX<=(x1+(buttonWidth/2))&&mouseY<=(y1+(buttonHeight/2)))
  {
    if (mousePressed)
    {
      screenState = number;

      health = 100;
      score = 0;
      enemiesKilled = 0;
      bulletsShot = 0;

      mE.clear();
      sE.clear();
      b.clear();
    }
  }
}