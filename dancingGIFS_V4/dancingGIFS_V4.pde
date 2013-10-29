//sketch for capturing GIFS
//made by Fer Diaz Smith. 

import processing.video.*;
import gifAnimation.*;
import processing.opengl.*;
import controlP5.*;

import java.awt.image.BufferedImage;
import java.awt.Color;

Capture video;
GifMaker myGif;
ControlP5 gui;

public int myColorRect = 200;
public int myColorBackground = 100;
int signal  = 0; 

int valueSlider;

String textValue; 
boolean gifRec =false;
String gifName = "testName";

long computerTime;
long runningTime;
//long interval = 3;
long lastTime;
int countDown;
//////////////////////////////////////////////////////////////////////////
//      SETUP
//////////////////////////////////////////////////////////////////////////
void setup() {
  size(900, 480);
  smooth(); 
  findOtherCams();//leaving this one out for now because it takes to much time
  video = new Capture(this, 640, 480); 
  video.start();
  //fo'the GIF's
  frameRate(12);   
 
  PFont font = createFont("GillSans-48", 20);
  gui = new ControlP5(this);

  gui.addSlider("sliderA", 300, 2000, 310, 
  740, 260, //this is the positioning
  100, 14);
  // add a vertical slider
  gui.addSlider("posterization")
    .setPosition(660, 305)
      .setSize(200, 20)
        .setRange(0, 200)
          .setValue(128)
            ;

  // reposition the Label for controller 'slider'
  gui.getController("posterization").getValueLabel().align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);
  gui.getController("posterization").getCaptionLabel().align(ControlP5.RIGHT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);

  // create a texfield
  gui.addTextfield("textA", 660, 150, 100, 20);



  gui.addButton("play")
    .setValue(128)
      .setPosition(660, 100)
        .updateSize()
          ;

  gui.addButton("stop")
    .setValue(128)
      .setPosition(730, 100)
        .updateSize()
          ;  
     
}
/* 
           ___           ___                       ___     
          /\__\         /\  \          ___        /\__\    
         /::|  |       /::\  \        /\  \      /::|  |   
        /:|:|  |      /:/\:\  \       \:\  \    /:|:|  |   
       /:/|:|__|__   /::\~\:\  \      /::\__\  /:/|:|  |__ 
      /:/ |::::\__\ /:/\:\ \:\__\  __/:/\/__/ /:/ |:| /\__\
      \/__/~~/:/  / \/__\:\/:/  / /\/:/  /    \/__|:|/:/  /
           /:/  /       \::/  /  \::/__/         |:/:/  / 
          /:/  /        /:/  /    \:\__\         |::/  /  
         /:/  /        /:/  /      \/__/         /:/  /   
         \/__/         \/__/                     \/__/    
 */

void draw() {
  background(84);
  fill(227);
  noStroke();
  rect(640,-2,260,124);
  
   fill(200,36,36);
  textSize(18);
  textAlign(CENTER);
  text(valueSlider,800,80);
  
  if (video.available()) video.read();
  image(video, 0, 0);
  
    
  if  (gifRec) {
    myGif.setDelay(valueSlider);
    myGif.addFrame();
    println("recording gif");
    countDown(8,2);
  }
}

//////////////////////////////////////////////////////////////////////////
//      GUI CONTROLLS    
//////////////////////////////////////////////////////////////////////////

public void play(int theValue) {
  println("a button event from buttonB: "+theValue);
  ellipse(300, 300, 30, 30);
  gifRec = true;
}

public void stop(int theValue) {
  println("a button event from buttonB: "+theValue);
  rect(300, 300, 30, 30);
  //      myGif.finish();
  gifRec = false;
}

public void sliderA(int theValue) {
  valueSlider = theValue;
  println(theValue);
}
public void controlEvent(ControlEvent theEvent) {
  println(theEvent.getController().getName());
  if (theEvent.getController().isActive() == true) {
    gifName = theEvent.getStringValue();
    gifName = gifName +".gif";
    myGif = new GifMaker(this, gifName);
    myGif.setSize(640, 480);
    myGif.setRepeat(0);
    myGif.setQuality(2);
    println(gifName);
    fill(255, 0, 0);
    ellipse(300, 300, 50, 50);
//    gifRec = true;

    countDown(3,1);
//    introSlide();
  }
  
}

void introSlide(){
  fill(243);
  noStroke();
  rect(0,0,640,480);
  fill(36);
  textSize(58);
  textAlign(CENTER);
  String minusGif = gifName.substring( 0, gifName.length()-4 );
  text(minusGif,320,240);
  
  myGif.setDelay(1300);
  myGif.addFrame();
   
}


void countDown(int interval, int mode){
  
  runningTime = millis();
  runningTime = runningTime/1000;
   countDown =  int((interval - ((millis()-lastTime)/1000)));
  println(countDown);
  
  fill(200,36,36);
  textSize(18);
  textAlign(CENTER);
  text(countDown,700,80);
  
 if (mode == 1){
 if (countDown <= 0) {
    gifRec = true;
    lastTime = millis();
  }
 } 
 else if(mode == 2){
    if (countDown <= 0) {
    gifRec = false;
    lastTime = millis();
  } 
 }
}

//void commands() {
//  if (keyPressed) {
//    if (key == 's') {
//      fill(255, 0, 0);
//      ellipse(10, 10, 10, 10);
//      myGif.finish();
//      gifRec=false;
//    } 
//    else if (key =='d') {
//      fill(0, 255, 0);
//      ellipse(10, 10, 10, 10);
//        gifRec=true;
//    }
//    else if (key == 'q') {
//      
//    }
//  }
//}

// function called at setup.. it finds other cameras. 
void findOtherCams() {
  String[] allCameras = Capture.list();
  if (allCameras.length == 0) {
    println("There are no video cameras available");
  }
  else {
    println("Cameras available:");
    for (int i = 0 ; i < allCameras.length ; i++) {
      println(allCameras[i]);
    }
  }
  // Or, the settings can be defined based on the text in the list
  //cam = new Capture(this, 640, 480, "Built-in iSight", 30);
}

