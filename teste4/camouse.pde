import processing.video.*;

interface ICamouseUser {
  void drawVideo();
  void drawCursor();
  void camouseStep();
  PApplet getApp();
  
}

Capture video = null;

Capture globalVideo(PApplet applet) {
    if (video == null) {
      String[] cameras = Capture.list();
      int i = 0;
      for (String s : cameras) {
        println("AA " + i + " : " + s);
        i++;
      }
      video = new Capture(applet, cameras[2]);
      video.start();
    } 
    println("AAA");
    return video;  
}

class Camouse  {

  int numPixels;
  int[] previousFrame;
  int[] xs;
  int[] ys;

  int tx, ty;

  Capture video;
  PImage v2;


  Camouse(PApplet applet) {
    video = globalVideo(applet);
    numPixels = 320*240; //video.width * video.height;
    println("BBB");

    previousFrame = new int[numPixels];
    xs = new int[numPixels];
    ys = new int[numPixels];
    
    v2 = mirror(video); 
    println("CCC");

  }

  PImage mirror(Capture video) {
    PImage img = new PImage( video.width, video.height);
    
    img.loadPixels();
    video.loadPixels();
    
    for (int c = 0;c< video.width-1;c++) {
      for (int r = 0;r< video.height-1;r++) {
        img.pixels[r* video.width+c]=video.pixels[(r* video.width)+( video.width-c)];
      }
    }
    return img;
  }

  void draw() {
    //if (1 < 2) { return; }
    if (video.available()) {
      //println("video available");
      // When using video to manipulate the screen, use video.available() and
      // video.read() inside the draw() method so that it's safe to draw to the screen
      video.read(); // Read the new frame from the camera
      video.loadPixels(); // Make its pixels[] array available

      v2 = mirror(video);

      //numPixels = v2.width * v2.height;
      println("numPixels :" + numPixels);

      int movementSum = 0; // Amount of movement in the frame
      int changed=0;
      int sense = 100;
      int sense2 = 50;
      
      for (int i = 0; i < numPixels; i++) {
        color currColor = v2.pixels[i];
        color prevColor = previousFrame[i];

        int currR = (currColor >> 16) & 0xFF; // Like red(), but faster
        int currG = (currColor >> 8) & 0xFF;
        int currB = currColor & 0xFF;
        // Extract red, green, and blue components from previous pixel
        int prevR = (prevColor >> 16) & 0xFF;
        int prevG = (prevColor >> 8) & 0xFF;
        int prevB = prevColor & 0xFF;
        // Compute the difference of the red, green, and blue values
        int diffR = abs(currR - prevR);
        int diffG = abs(currG - prevG);
        int diffB = abs(currB - prevB);


        int diff = (diffR + diffG + diffB);
        
        if (diff > sense) {         
          xs[changed] = i % video.width;
          ys[changed] = (int)i/video.width;
          changed=changed+1;
        }       
        previousFrame[i] = currColor;

        if (i==0) {
          //println(i, currColor, prevColor, diff, xs[changed], ys[changed]);
        }
      }

      println("III");

      println("changed " + changed);

      if (changed < sense2) { return; }  
      tx=0;
      ty=0;
      for (int i=0; i<changed; i++) {
        tx = tx+xs[i];
        ty = ty+ys[i];
      }
      if (changed>0) {
        tx = tx/changed;
        ty = ty/changed;
      } else {
        tx = 0;
        ty = 0;
      }
    } else {
     // println("no video");      
    }
  }

  int x() { return tx; }
  int y() { return ty; }
  
  PImage getVideo() { 
    return v2;
  }
  
  String diagnostic() { return "Camouse"; }
}