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

  if (key == 'q')
  {
    depthDown = true;
  }

  if (key == 'e')
  {
    depthUp = true;
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
  
  if (key == 'q')
  {
    depthDown = false;
  }

  if (key == 'e')
  {
    depthUp = false;
  }
}

void camMove()
{
  if (upPressed)
  {
    camPos.y -= speed;
  }

  if (downPressed)
  {
    camPos.y += speed;
  }

  if (leftPressed)
  {
    camPos.x -= speed;
  }

  if (rightPressed)
  {
    camPos.x += speed;
  }
  
  if(depthDown)
  {
   camPos.z -= speed; 
  }
  
  if(depthUp)
  {
   camPos.z += speed; 
  }
}