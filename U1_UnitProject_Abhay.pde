import damkjer.ocd.*;

PVector camPos;

Camera cam;

void setup()
{
  fullScreen(P3D);

  camPos = new PVector(width/2, height/2, 0);

  cam = new Camera(this, camPos.x, camPos.y, camPos.z, -1, -1, 0);
}

void draw()
{
  background(0);
  
  cam.feed();
}

void mouseLook()
{
  cam.pan(radians((mouseX - pmouseX)/2));
  cam.tilt(radians((mouseY - pmouseY)/2));
}