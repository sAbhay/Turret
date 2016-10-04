void mouseLook()
{
  cam.pan(radians((mouseX - pmouseX)/2.000));
  cam.tilt(radians((mouseY - pmouseY)/2.000));
}