import gifAnimation.*;
import oscP5.*;
OscP5 oscP5;

String currentMessage = "";

String[] expressions = {"NEUTRAL", "SURPRISED", "EXCITED", "SAD", "FLIRTY"};
PImage[] animation;
PImage bg;
Gif[] reactionGifs;
int index = 0;

PFont myFont;

public void setup() {
  size(1000, 800);
  frameRate(100);
  oscP5 = new OscP5(this, 12000);
  
  myFont = createFont("Impact", 96);
  textFont(myFont);
  textAlign(CENTER);  
  
  reactionGifs = new Gif[5];
  for (int i = 0; i<5; i++) {
    reactionGifs[i] = new Gif(this, i + ".gif");
    reactionGifs[i].loop();
  }
  bg = loadImage("bg.png");
}

void draw() {
  background(bg);
  image(reactionGifs[index], 0, 0, width, height - 200);
  
  stroke(0,255,0);
  strokeWeight(5);
  noFill();
  rect(index*200, height-200, 200, 200);
  
  fill(0,255,0);
  textSize(48);
  text("Current expression:", width-220 ,50);
  textSize(96);
  fill(255,0,255);
  text(expressions[index], width-220 ,150);
  
}


void oscEvent(OscMessage theOscMessage) {
  println("received message");
  if (theOscMessage.checkAddrPattern("/wek/outputs") == true) {
    if (theOscMessage.checkTypetag("f")) {
      float f = theOscMessage.get(0).floatValue();
      println("received1: " + f);
      currentMessage = Float.toString(f);
      int recieved = int (currentMessage);
      index = recieved - 1;
    }
  }
}