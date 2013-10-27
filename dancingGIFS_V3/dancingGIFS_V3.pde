//sketch for capturing GIFS
//made by Fer Diaz Smith. 

import processing.video.*;
import gifAnimation.*;
import processing.opengl.*;
import controlP5.*;

import java.awt.image.BufferedImage;
import java.awt.Color;

Capture video;
GifEncoder myGif;

public int myColorRect = 200;
public int myColorBackground = 100;
int signal  = 0; 

String textValue; 
boolean gifRec =false;


void setup() {
  size(1080, 480);
  smooth();
  
  myGif = new GifEncoder();
  myGif.setFrameRate(8);
      myGif.start("me2.gif");
  

  //  findOtherCams();//leaving this one out for now because it takes to much time
  video = new Capture(this, 640, 480); 
  video.start();
  //fo'the GIF's
  frameRate(12);         
  background(36);
}

void draw() {
  if (video.available()) video.read();
  image(video, 0, 0);
  commands();

  if  (gifRec) {
    myGif.setDelay(20);
    this.loadPixels();
    addFrame(this.pixels,640,480);
println("recording gif");
    
   }
}


void commands() {
  if (keyPressed) {

    if (key == 's') {
      fill(255, 0, 0);
      ellipse(10, 10, 10, 10);
      myGif.finish();
      gifRec=false;
    } 
    else if (key =='d') {
      fill(0, 255, 0);
      ellipse(10, 10, 10, 10);


        gifRec=true;
    }
    else if (key == 'q') {
      
    }
  }
}

void addFrame(int[] pixels, int width, int height) {
    BufferedImage frame = new BufferedImage(width, height,
        BufferedImage.TYPE_INT_ARGB);
    frame.setRGB(0, 0, width, height, pixels, 0, width);
    myGif.addFrame(frame);
  }
  
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

