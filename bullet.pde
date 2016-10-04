class Bullet
{
  PVector pos;
  PVector dir;

  float speed;
  float size;

  Bullet(PVector _start, PVector _target, float _speed)
  {
    size = 5; 
    speed = _speed;

    pos = new PVector(_start.x, _start.y, _start.z); // _start determines the spawn point
    dir = new PVector(_target.x, _target.y, _target.z); // _target determines target

    dir = PVector.sub(_start, _target); // causes the bullet to move at angle based on its target's relative position from the spawn point

    dir.normalize();
    dir.mult(-speed);
  }

  void display()
  {
    pushMatrix();

    translate(pos.x, pos.y, pos.z);
    noStroke();
    fill(0, 255, 0);
    sphere(size);

    popMatrix();
  }

  void move()
  {
    pos.add(dir);
  }
  
  void update()
  {
   display();
   move();
  }
}