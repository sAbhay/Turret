class ShootingEnemy extends Enemy
{
  float fireRate;
  float time;

  ArrayList<Bullet> bullets = new ArrayList<Bullet>(); // ArrayList of bullets that it shoots

  ShootingEnemy(PVector _pos, float _size, int _textureNo, float _fireRate)
  {
    super(_pos, _pos, 0, _size, _textureNo);

    fireRate = _fireRate;
    time = millis();
  }

  void shoot(PVector _start, PVector _target)
  {
    if (time < millis()) // millis() timer
    {
      bullets.add(new Bullet(_start, _target, 20, color(255, 0, 0)));
      time += fireRate;
    }

    for (int i = 0; i < bullets.size(); i++)
    {
      bullets.get(i).update();

      if (bullets.size() != 0)
      {
        if (dist(bullets.get(i).pos.x, bullets.get(i).pos.y, bullets.get(i).pos.z, player.pos.x, player.pos.y, player.pos.z) < size/2)
        {
          health -= 1;
        }

        if (bullets.get(i).pos.x < -width || bullets.get(i).pos.x > width || bullets.get(i).pos.y < 0 || bullets.get(i).pos.y > height || bullets.get(i).pos.z < -range || bullets.get(i).pos.z > 0)
        {
          bullets.remove(i);
        }
      }
    }
  }
}