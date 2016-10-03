class Player
{
  PVector pos;
  float speed;
  float size;

  Player()
  {
    pos = new PVector(width/2, height/2, 0);
    speed = 15;
    size = 50;
  }
  
  void display()
  {
   pushMatrix();
   
   translate(pos.x, pos.y, pos.z);
   box(size);
   
   popMatrix();
  }
  
  void forward()
  {
    pos.z -= speed;
  }
  
  void back()
  {
    pos.z += speed;
  }
  
  void left()
  {
    pos.x -= speed;
  }
  
  void right()
  {
    pos.x += speed;
  }
}