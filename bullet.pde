class Bullet
{
  PVector pos;
  PVector dir;

  float speed;
  float size;
  
  color colour;

  Bullet(PVector _start, PVector _target, float _speed, color _colour)
  {
    size = 5; 
    speed = _speed;

    pos = new PVector(_start.x, _start.y, _start.z); // _start determines the spawn point
    dir = new PVector(_target.x, _target.y, _target.z); // _target determines target

    dir = PVector.sub(_start, _target); // causes the bullet to move at angle based on its target's relative position from the spawn point

    dir.normalize();
    dir.mult(-speed);
    
    colour = _colour;
  }

  void display()
  {
    pushMatrix();

    translate(pos.x, pos.y, pos.z); // draws bullets at pos
    noStroke();
    fill(colour);
    sphere(size);

    popMatrix();
  }

  void move()
  {
    pos.add(dir); // causes the bullet to move towards the target every tick
  }
  
  void update()
  {
   display();
   move();
  }
}