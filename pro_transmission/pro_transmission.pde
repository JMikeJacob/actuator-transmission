//made with processing-3.0.2 (Java)
import processing.serial.*;

Serial myPort;
String port;
String transmission;

void setup() {
  size(1080, 720);
  noStroke();
  rectMode(CENTER);
  
  port = findPort();
  if (port != null)  
  {
    new Serial(this, port, 9600).bufferUntil(ENTER);
  }
  else
  {
    println("No available ports");
    exit();
  }
}
  int accLeft=0;
  int accRight=0;
  int winWid = 1080;
  int winLen = 720;
  int recWid = 150;
  int recLen = 580;
  int controlWid = recWid - 20;
  int controlLen = 60;
  int controlRX = winWid/2 + 200;
  int controlRY = controlLen/2 + 60;
  int controlLX = winWid/2 - 200;
  int controlLY = controlLen/2 + 60;
  boolean has_changed = false;
  boolean left_on = false;
  boolean right_on = false;
  
void draw() {
  background(255);
  fill(127);
  rect(winWid/2 + 200, recLen/2 + 50, recWid, recLen);
  
  fill(0);
  rect(controlRX, controlRY, controlWid, controlLen);  
  fill(127);
  rect(winWid/2 - 200, recLen/2 + 50, recWid, recLen);
  
  fill(0);
  rect(controlLX, controlLY, controlWid, controlLen);
  
  textSize(32);
  fill(0, 102, 153);
  text(accLeft, winWid/2 - 190, 40);
  text(accRight, winWid/2 + 190, 40);
  
  writeToPort();
}

void writeToPort()
{
  if(has_changed)
  {
    transmission = "L" + accLeft + "R" + accRight;
    myPort.write(transmission);
    println("Port: " + port + ", Serial: " + 9600 + ", sending: " + accLeft + ", " + accRight);
  }
}

static final String findPort()
{
  String[] ports = Serial.list();
  for (String p : ports)  
  {
      if(p == "COM1" || p == "COM2" || p == "COM3" || p == "COM4" || p == "COM5")
      {
        println("Found Port: " + p);
        return p; 
      }
  }
  return null;
}

void mousePressed()
{
   if(mouseX <= controlRX + controlWid/2 && 
      mouseX >= controlRX - controlWid/2 && 
      mouseY <= controlRY + controlLen/2 && 
      mouseY >= controlRY - controlLen/2)
   {
     right_on = true; 
   }
   if(mouseX <= controlLX + controlWid/2 && 
      mouseX >= controlLX - controlWid/2 && 
      mouseY <= controlLY + controlLen/2 && 
      mouseY >= controlLY - controlLen/2)
   {
     left_on = true; 
   }
}

void mouseDragged()
{
  if(right_on == true)
  {
      if(mouseY >= 90 && mouseY <= recLen + 10)
      {
         controlRY = mouseY;
         accRight = (controlRY - 90)/5;
         has_changed = true;
      }
  }
  if(left_on == true)
  {
      if(mouseY >= 90 && mouseY <= recLen + 10)
      {
         controlLY = mouseY;
         accLeft = (controlLY - 90)/5;
         has_changed = true;
      }
  }
}

void mouseReleased()
{
  left_on = false;
  right_on = false;
  has_changed = false;
}