class Object
{
 PVector pos;
 PShape sphere;
 
 float size;
 int textureNo;
 
 Object(PVector _pos, float _size, int _textureNo)
 {
   pos = _pos;
   
   size = _size;
   
   textureNo = _textureNo;
   
   sphere = createShape(SPHERE, size);
   
   switch(textureNo)
   {
    case 0:
    break;
    
    case 1:
    break;
    
    case 2:
    break;
   }
 }
 
 void display()
 {
   pushMatrix();
   
   translate(pos.x, pos.y, pos.z);
   shape(sphere);  
   
   popMatrix();
 }
}