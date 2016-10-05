class Player // essentially, a collection of variables
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
}