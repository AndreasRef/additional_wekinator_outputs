import ddf.minim.*;
import oscP5.*;
import netP5.*;
OscP5 oscP5;

Minim minim;
AudioSample sound1;
AudioSample sound2;

int lastClass = 0;
int currentClass = 0;

void setup()
{
  size(512, 200, P3D);
  minim = new Minim(this);
  oscP5 = new OscP5(this, 12000); //listen for OSC messages on port 12000 (Wekinator default)

  // load BD.wav from the data folder
  sound1 = minim.loadSample( "BD.mp3", 512);
  
  // if a file doesn't exist, loadSample will return null
  if ( sound1 == null ) println("Didn't get sound1!");
  
  // load SD.wav from the data folder
  sound2 = minim.loadSample("SD.wav", 512);
  if ( sound2 == null ) println("Didn't get sound2!");
}

void draw()
{
  background(0);
}

//This is called automatically when OSC message is received
void oscEvent(OscMessage theOscMessage) {
  println("received message");
  if (theOscMessage.checkAddrPattern("/wek/outputs") == true) {
    if (theOscMessage.checkTypetag("f")) {
      float f = theOscMessage.get(0).floatValue();
      println("received1: " + f);
      currentClass = int (f);
      
      if (currentClass != lastClass) {
        if (currentClass == 1) sound1.trigger();
        if (currentClass == 2) sound2.trigger();
      }
      lastClass = currentClass;
    }
  }
}