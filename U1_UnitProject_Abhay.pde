import damkjer.ocd.*;

boolean upPressed, downPressed, leftPressed, rightPressed;
float movementSpeed = 20;

Camera cam;

float range = 5000;

PVector paddle;
float paddleSize = 50;

float[] target;
float[] camPos;

ArrayList<Bullet> b = new ArrayList<Bullet>();

Player player;

void setup()
{
  fullScreen(P3D);
  noStroke();
  rectMode(CENTER);

  noCursor();

  player = new Player();
  cam = new Camera(this, player.pos.x, player.pos.y, player.pos.z, player.pos.x, player.pos.y, -range);
}

void draw()
{
  background(0);

  //cam = new Camera(this, player.pos.x, player.pos.y, player.pos.z, player.pos.x, player.pos.y, -range);

  target = cam.target();
  camPos = cam.position();

  cam.feed();
  mouseLook();
  camMove();

  player.pos.x = camPos[0];
  player.pos.y = camPos[1];
  player.pos.z = camPos[2];

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

  player.display();

  for (int i = 0; i < b.size(); i++)
  {
    b.get(i).update(); 

    if (b.get(i).pos.x < 0 || b.get(i).pos.x > width || b.get(i).pos.y < 0 || b.get(i).pos.y > height || b.get(i).pos.z > 0 || b.get(i).pos.z < -range)
    {
      b.remove(i);
    }
  }
}

void mouseLook()
{
  cam.pan(radians((mouseX - pmouseX)/2));
  //cam.tilt(radians((mouseY - pmouseY)/2));
}

void camMove()
{
  if (upPressed)
  {
    //player.forward();
    cam.dolly(-player.speed);
  }

  if (downPressed)
  {
    //player.back();
    cam.dolly(player.speed);
  }

  if (leftPressed)
  {
    //player.left();
    cam.truck(-player.speed);
  }

  if (rightPressed)
  {
    //player.right();
    cam.truck(player.speed);
  }
}

void keyPressed()
{
  if (key == 'w')
  {
    upPressed = true;
  }

  if (key == 's')
  {
    downPressed = true;
  }

  if (key == 'a')
  {
    leftPressed = true;
  }

  if (key == 'd')
  {
    rightPressed = true;
  }
}

void keyReleased()
{
  if (key == 'w')
  {
    upPressed = false;
  }

  if (key == 's')
  {
    downPressed = false;
  }

  if (key == 'a')
  {
    leftPressed = false;
  }

  if (key == 'd')
  {
    rightPressed = false;
  }
}

void mousePressed()
{
  PVector _camPos = new PVector(camPos[0], camPos[1], camPos[2]);
  PVector _target = new PVector(target[0], target[1], target[2]);

  b.add(new Bullet(_camPos, _target));
}