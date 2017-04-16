/* Wekinator->RobotKeyPress - Triggers keyboard presses on your computer! 

Can be used to play games like:

Wolfenstein:  http://3d.wolfenstein.com/game_EU.php 
Controls: Left, Right, Up, X, Space
Suggested delay time: 50?

Tetris: http://www.freetetris.org/game.php
Controls: Left, Right, X
Delay time: 50?

Google T-Rex Game: http://apps.thecodepost.org/trex/trex.html SPACE 
Controls: Space
Delay time: 100

*/

//Necessary for OSC communication with Wekinator:
import oscP5.*;
import netP5.*;
OscP5 oscP5;

import java.awt.AWTException;
import java.awt.Robot;
import java.awt.event.KeyEvent;

Robot robot;

boolean singleTrigger = true;

int delayTime = 100;

float lastInput = 1;

String currentMessage = "";
void setup() {
  size(400, 400);

  oscP5 = new OscP5(this, 12000); //listen for OSC messages on port 12000 (Wekinator default)

  //Let's get a Robot...
  try { 
    robot = new Robot();
  } 
  catch (AWTException e) {
    e.printStackTrace();
    exit();
  }
}

void draw() {
  background(255);
  fill(0);
  text("Receives 1 classifier output message from wekinator", 10, 10);
  text("Listening for OSC message /wek/outputs, port 12000", 10, 30);
  text("last message: " + currentMessage, 10, 180);
}

//This is called automatically when OSC message is received
void oscEvent(OscMessage theOscMessage) {
  println("received message");
  if (theOscMessage.checkAddrPattern("/wek/outputs") == true) {
    if (theOscMessage.checkTypetag("f")) {
      //int f = theOscMessage.get(0).intValue();
      float f = theOscMessage.get(0).floatValue();
      println("received1: " + f);
      currentMessage = Float.toString(f);
    
      if (lastInput !=f) { //Only trig if the classification is different from the last

        if (f == 1) { 
          //DO NOTHING (neutral class)
        }

        if (f == 2) {
          println("X");
          robot.keyPress(KeyEvent.VK_X);
          delay(delayTime);
          robot.keyRelease(KeyEvent.VK_X);
        }

        if (f == 3) {
          println("LEFT");
          robot.keyPress(KeyEvent.VK_LEFT);
          delay(delayTime);
          robot.keyRelease(KeyEvent.VK_LEFT);
        }

        if (f == 4) {
          println("RIGHT");
          robot.keyPress(KeyEvent.VK_RIGHT);
          delay(delayTime);
          robot.keyRelease(KeyEvent.VK_RIGHT);
        }

        if (f == 5) {
          println("UP");
          robot.keyPress(KeyEvent.VK_UP);
          delay(50);
          robot.keyRelease(KeyEvent.VK_UP);
        }

        if (f == 6) {
          println("SPACE");
          robot.keyPress(KeyEvent.VK_SPACE);
          delay(delayTime);
          robot.keyRelease(KeyEvent.VK_SPACE);
        }
      }
      lastInput = f;
    }
  }
}