class MovingEnemy extends Enemy
{
  MovingEnemy(PVector _start, PVector _target, float _speed, float _size, int _textureNo)
  {
    super(_start, _target, _speed, _size, _textureNo);
  }
  
  void checkCollision() // checks whether enemy has hit player
  {
   if(pos.x >= player.pos.x - player.size/2 && pos.x <= player.pos.x + player.size/2 && pos.y >= player.pos.y - player.size/2 && pos.y <= player.pos.y + player.size/2 && pos.z >= player.pos.z - player.size/2 && pos.z <= player.pos.z + player.size/2)
   {
    health -= 4; // decreases player's health when enemy hits it
   }
  }
}