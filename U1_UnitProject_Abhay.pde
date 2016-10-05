/*
  Block Game - Abhay Singhal
  
  This is a survival FPS game with a stationary player and two types of enemies
*/

import damkjer.ocd.*;

Camera cam;
Camera staticCam;

float range = 10000; // z-length of the space

float[] target; // tracks camera's target in the form of a float array: [0] = x, [1] = y, [2] = z
float[] camPos; // tracks camera's position in the form of a float array: [0] = x, [1] = y, [2] = z

ArrayList<Bullet> b = new ArrayList<Bullet>();
ArrayList<MovingEnemy> mE = new ArrayList<MovingEnemy>();
ArrayList<ShootingEnemy> sE = new ArrayList<ShootingEnemy>();

PVector bulletTarget; // crosshair position, camera's target

PVector spawn; // enemy spawn

Player player;

float health = 100; // tracks player's health
float score = 0; // tracks player's score

int bulletsShot = 0; // tracks how many bullets have been fired
int enemiesKilled = 0; // tracks how many enemies have been killed by bullets

int shootingKilled = 0; // tracks how many shooting enemies have been killed by bullets
int movingKilled = 0; // tracks how many moving enemies have been killed by bullets

int screenState = 0;

void setup()
{
  fullScreen(P3D);
  noStroke();
  rectMode(CENTER);

  noCursor();

  PVector playerSpawn = new PVector(0, height/2, 0); // determines player's spawn point

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
  case 0: // start screen

    staticCam.feed();

    cursor();

    textSize(108);
    text("Block Game", width/2, height/10);

    textSize(64);
    text("A survival FPS (with blocks)", width/2, height - (height/10));

    button(width/2 - 50, height/2, 120, 1, "Play"); // button that transitions to in-game screen

    break;

  case 1: // in-game screen

    noCursor();

    target = cam.target();
    camPos = cam.position();

    cam.feed();
    mouseLook();

    // sets player position to camera position 

    player.pos.x = camPos[0];
    player.pos.y = camPos[1];
    player.pos.z = camPos[2];

    bulletTarget = new PVector(target[0], target[1], target[2]);

    if (mE.size() <= 5 + (int) (movingKilled/15)) // initial maximum of 5, adds more to the maximum based on how many have been been killed, scaling difficulty
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

    if (sE.size() <= 2) // maximum of three shooting enemies
    {
      int spawnPlace = (int) random(2);

      switch(spawnPlace)
      {
      case 0:
        spawn = new PVector(-width + 100, random(height), random(-3*range/4, -range/4));
        sE.add(new ShootingEnemy(spawn, random(50, 200), 0, random(4000, 8000)));
        break;

      case 1:
        spawn = new PVector(width - 100, random(height), random(-3*range/4, -range/4));
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

      if (mE.get(i).pos.x < -width || mE.get(i).pos.x > width || mE.get(i).pos.z > 0 || mE.get(i).pos.z < -range || mE.get(i).pos.y < 0 || mE.get(i).pos.y > height) // if moving enemy position lies outside the defined space
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
      sE.get(i).shoot(sE.get(i).pos, player.pos); // add bullets that move towards the player's position from the enemy's position

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
    sphere(30); // crosshair, aiming reticule
    strokeWeight(5);
    stroke(0, 255, 0);
    noFill();
    arc(0, 0, 300, 300, 0, radians(health*3.6)); // health indicator
    fill(255);
    textSize(200);
    text((int) score, - width/2 + 200, - height/2 + 100); // score indicator
    popMatrix();

    strokeWeight(1);
    noStroke();
    fill(255);

    health += 0.025; // incrementally add health 

    if (health >= 100)
    {
      health = 100; // caps health
    }

    if (health <= 0)
    {
      screenState = 2; // game ends when health <= 0
    }

    break;

  case 2: // game over screen

    staticCam.feed();

    // display game stats

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

void mousePressed() // add bullet when mousePressed
{
  if (screenState == 1)
  { 
    b.add(new Bullet(player.pos, bulletTarget, 100, color(0, 255, 0)));
    score -= 3;
    bulletsShot++;
  }
}

void keyPressed()
{
  if (screenState != 0)
  {
    if (key == ESC) // return to start screen
    {
      key = 0;

      screenState = 0;
    }
  }
}

void button(float x1, float y1, int buttonHeight, int number, String buttonText)
{
  float buttonWidth = buttonText.length() * 13 * 1.5384615385 * 3; // makes buttonWidth variable based on the length of buttonText
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
      screenState = number; // change screen

      // reset game stats, start new game

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