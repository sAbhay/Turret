class Enemy
{
 PVector pos;
 
 float size;
 int textureNo;
 
 PShape enemy;
 
 Enemy(PVector _pos, float _size, int _textureNo)
 {
   pos = _pos;
   
   size = _size;
   
   textureNo = _textureNo;
   
   enemy = createShape(BOX, size);
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
   
 }
 
 void update()
 {
   
 }
}