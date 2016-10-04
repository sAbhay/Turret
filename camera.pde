void mouseLook()
{
  cam.pan(radians((mouseX - pmouseX)/2));
  cam.tilt(radians((mouseY - pmouseY)/2));
}