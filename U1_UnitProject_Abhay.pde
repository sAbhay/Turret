import damkjer.ocd.*;

boolean upPressed, downPressed, leftPressed, rightPressed;
float movementSpeed = 20;

Camera cam;

float range = 5000;

PVector paddle;
float paddleSize = 50;

float[] target;
float[] camPos;

void setup()
{
  fullScreen(P3D);
  noStroke();
  rectMode(CENTER);

  noCursor();

  cam = new Camera(this, width/2, height/2, 0, width/2, height/2, -range);
}

void draw()
{
  background(0);

  target = cam.target();
  camPos = cam.position();

  cam.feed();
  mouseLook();
  camMove();

  pushMatrix();
  translate(width/2, height/2, -range/2);
  noFill();
  stroke(255);
  box(width, height, range);
  popMatrix();

  noStroke();
  fill(255);
  pushMatrix();
  translate(target[0], target[1], target[2]);
  sphere(15);
  popMatrix();
}

void mouseLook()
{
  cam.pan(radians((mouseX - pmouseX)/2));
  cam.tilt(radians((mouseY - pmouseY)/2));
}

void camMove()
{
  //if (camPos[1] >= 0 && camPos[1] <= height && camPos[0] >= 0 && camPos[0] <= width && camPos[2] <= 0 && camPos[2] >= -range)
  {
    if (upPressed)
    {
      cam.dolly(-movementSpeed);
    }

    if (downPressed)
    {
      //cam.dolly(movementSpeed);
    }

    if (leftPressed)
    {
      cam.truck(-movementSpeed);
    }

    if (rightPressed)
    {
      cam.truck(movementSpeed);
    }
  }
}

void keyPressed()
{
  switch(key)
  {
  case 'w':
    upPressed = true;

  case 's':
    downPressed = true;

  case 'a':
    leftPressed = true;

  case 'd':
    rightPressed = true;
  }
}

void keyReleased()
{
  switch(key)
  {
  case 'w':
    upPressed = false;

  case 's':
    downPressed = false;

  case 'a':
    leftPressed = false;

  case 'd':
    rightPressed = false;
  }
}