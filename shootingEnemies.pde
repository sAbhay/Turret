class ShootingEnemy extends Enemy
{
  float fireRate;
  float time;

  ArrayList<Bullet> bullets = new ArrayList<Bullet>(); 

  ShootingEnemy(PVector _pos, float _size, int _textureNo, float _fireRate)
  {
    super(_pos, _pos, 0, _size, _textureNo);

    fireRate = _fireRate;
    time = millis();
  }

  void shoot(PVector _start, PVector _target)
  {
    if (time < millis())
    {
      bullets.add(new Bullet(_start, _target, 20));
      time += random(fireRate);
    }

    for (int i = 0; i < bullets.size(); i++)
    {
      bullets.get(i).update();
      
      if(bullets.get(i).pos.x < -width || bullets.get(i).pos.x > width || bullets.get(i).pos.y < 0 || bullets.get(i).pos.y > height || bullets.get(i).pos.z < -range || bullets.get(i).pos.z > 0)
      {
       bullets.remove(i); 
      }
    }
  }
}