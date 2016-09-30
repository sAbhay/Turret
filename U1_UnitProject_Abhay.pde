import damkjer.ocd.*;

PVector camPos;

boolean upPressed, downPressed, leftPressed, rightPressed, depthUp, depthDown;
float speed = 1;

ArrayList<Object> s = new ArrayList<Object>();

PVector sPos;

Camera cam;

void setup()
{
  fullScreen(P3D);
  noStroke();

  camPos = new PVector(width/2, height/2, 0);

  cam = new Camera(this, camPos.x, camPos.y, camPos.z, -1, -1, 0);
  
  for(int i = 0; i < 9 ; i++)
  {
    sPos = new PVector(random(width), random(height), random(-400, 400));
    
   s.add(new Object(sPos, random(10), 0)); 
  }
}

void draw()
{
  background(0);

  cam.feed();
  mouseLook();
  
  camMove();
  
  for(int i = 0; i < s.size(); i++)
  {
   s.get(i).display(); 
  }
}

void mouseLook()
{
  cam.pan(radians((mouseX - pmouseX)/2));
  cam.tilt(radians((mouseY - pmouseY)/2));
}