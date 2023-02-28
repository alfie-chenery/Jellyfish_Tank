Jellyfish[] jellylist;
int N = 25;
String colour_mode = "rainbowier"; // white/realistic/rainbow//rainbowier
String background_mode = "black"; // black/blue/rainbow/picture
boolean motion_blur = true; //motion blur only available with black bg
PImage bg;

void setup(){
  fullScreen();
  
  if(background_mode == "picture"){
    bg = loadImage("bg.png");
    bg.resize(0,height);
  }
  //size(800,800);
  background(0);
  colorMode(HSB,360);
  jellylist = new Jellyfish[N];
  for (int i=0; i<N; i++){
    Jellyfish j = new Jellyfish();
    jellylist[i] = j;
  }
}



void draw(){
  if (background_mode == "picture"){
    background(bg);
  }else{
    }if (background_mode == "blue"){
      fill(230,360,200); 
      stroke(230,360,200); 
    }else if(background_mode == "rainbow"){
      fill(frameCount%360,360,360);
      stroke(frameCount%360,360,360);
    }else{//default to black background
      if (motion_blur == true){
        fill(0,100);
        stroke(0,100);
      }else{
        fill(0);
        stroke(0);
      }
    }
    rect(0,0,width,height);


  for (int i=0; i<jellylist.length;i++){
    jellylist[i].update();
    jellylist[i].render();
    if (jellylist[i].offscreen()){ //if jelly fish goes off screen replace it with new one
      jellylist[i] = new Jellyfish();
    }
  } 
}
