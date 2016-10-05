class Enemy
{
  PVector pos;
  PVector dir;
  PVector start;
  PVector target;

  float speed;

  float size;
  int textureNo;

  PShape enemy;
  boolean killed = false;

  Enemy(PVector _start, PVector _target, float _speed, float _size, int _textureNo)
  {
    pos = new PVector(_start.x, _start.y, _start.z);
    dir = new PVector(_target.x, _target.y, _target.z);

    speed = _speed;

    size = _size;

    textureNo = _textureNo;

    enemy = createShape(BOX, size);

    dir = PVector.sub(_target, _start);
    dir.normalize();
    dir.mult(speed);
  }

  void display()
  {
    pushMatrix();

    translate(pos.x, pos.y, pos.z);
    shape(enemy);

    popMatrix();
  }

  void move()
  {
    pos.add(dir);
  }

  void checkIfShot()
  {
    for (int i = 0; i < b.size(); i++)
    {
      if (b.get(i).pos.z >= pos.z - size/2 && b.get(i).pos.z <= pos.z + size/2 && b.get(i).pos.x >= pos.x - size/2 && b.get(i).pos.x <= pos.x + size/2 && b.get(i).pos.y >= pos.y - size/2 && b.get(i).pos.y <= pos.y + size/2)
      {
        killed = true;
      }
    }
  }

  void checkBoundaries()
  {
    if (pos.x < -width || pos.x > width || pos.z > 0 || pos.z < -range || pos.y < 0 || pos.y > height)
    {
      killed = true;
    }
  }

  void update()
  {
    display();
    move();
    checkIfShot();
    checkBoundaries();
  }
}