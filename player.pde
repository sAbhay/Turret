class Player
{
  PVector pos;
  float speed;
  float size;
  
  boolean killed = false;

  Player(PVector _pos)
  {
    pos = _pos;
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
}