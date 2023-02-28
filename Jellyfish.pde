class Jellyfish{
  int wavyness = 25;//10,25
  PVector pos;
  float size;
  float facing;
  float speed;
  PVector move;
  float turnbuffer; //added to make turns smoother
  color colour;
  int age;
  float heartbeat;//used for cyclic chaanges of speed and shape
  
  float tentacletime = 0;
  float coefficient1;
  float coefficient2;
  float coefficient3;
  float coefficient4;
  float coefficient5;
  
  //constructor
  Jellyfish(){
    size=random(50,150);
    
    //define spawn location
    int side = (int)random(4);
    if(side==0){//top
      pos = new PVector(random(width),-2*size);
    }else if(side==1){//left
      pos = new PVector(-2*size,random(height));
    }else if(side==2){//bottom
      pos = new PVector(random(width),height+2*size);
    }else if(side==3){//right
      pos = new PVector(width+2*size,random(height));
    }
    
    //force to face inwards
    facing = atan2(height/2-pos.y,width/2-pos.x);//face to centre
    facing+=random(-PI/4,PI/4);//add random variation
    
    speed = random(15,25);
    move = new PVector(cos(facing),sin(facing));
    move.setMag(speed);
    age = (int)random(180); //starting with random age means movement is out of sync from other jellyfish
    heartbeat = abs(0.1*(1.5+sin(radians(age*5))));
    
    if (colour_mode=="rainbow"){
      colour = color(random(360),300,360);
    }else if(colour_mode=="realistic"){
      colour = color(random(250,310),300,360);
    }else{//default to white mode
      colour = color(360); 
    }
    
    //tentacle coefficients
    coefficient1 = random(0.9,1.1);
    coefficient2 = random(0.5,0.7);
    coefficient3 = random(-0.3,0.3);
    coefficient4 = random(-0.7,-0.5);
    coefficient5 = random(-1.1,-0.9);
  }
  
  
    void update(){
    pos.x+=move.x*heartbeat;
    pos.y+=move.y*heartbeat;
    age++;

    heartbeat = abs(0.1*(1.5+sin(radians(age*5))));
    if (age%180==0){ // if at slowest point
      float chance = random(2);
      if (chance<1){
        float change = random(-30,30);
        turnbuffer += change;
      }
    }
    
    if (turnbuffer>0){
      facing+=radians(1);
      turnbuffer--;
      move = new PVector(cos(facing),sin(facing));//update direction of movement only when facing direction changes
      move.setMag(speed);
    }
  }
  
  
  
  void render(){
    
    if (colour_mode=="rainbowier"){
       colour = color(age%360,360,360);
    }
      
    stroke(colour);
    fill(colour);
    arc(pos.x,pos.y,size,size,radians(-112.5)+facing-heartbeat,radians(-112.5)+(1.25*PI)+facing+heartbeat,CHORD);
  
    //tentacle calculations
    strokeWeight(3);
    noFill();
  
    PVector A = new PVector(pos.x-0.4*size*sin(-facing),pos.y-0.4*size*cos(-facing));
    PVector B = new PVector(pos.x-0.2*size*sin(-facing),pos.y-0.2*size*cos(-facing));
    PVector C = pos;
    PVector D = new PVector(pos.x+0.2*size*sin(-facing),pos.y+0.2*size*cos(-facing));
    PVector E = new PVector(pos.x+0.4*size*sin(-facing),pos.y+0.4*size*cos(-facing));

  //tentacle1 //coeficient= average 1
    beginShape();
    for(float i=0; i<HALF_PI*size/100; i+=0.01){
      float x = 100*-i;
      float y = -(wavyness*i*coefficient1*sin(i-1.05*tentacletime));
      float xold = x;
      x = (x*cos(facing)) - y*sin(facing);
      y = (y*cos(facing)) + xold*sin(facing);
      vertex(A.x+x,A.y+y);
    }
    endShape();
    
  //tentacle2 //coeficient= average 0.6
    beginShape();
    for(float i=0; i<HALF_PI*size/100; i+=0.01){
      float x = 100*-i;
      float y = -(wavyness*i*coefficient2*sin(i-1.05*tentacletime));
      float xold = x;
      x = (x*cos(facing)) - y*sin(facing);
      y = (y*cos(facing)) + xold*sin(facing);
      vertex(B.x+x,B.y+y);
    }
    endShape();
    
  //tentacle3 //coeficient= average 0
    beginShape();
    for(float i=0; i<HALF_PI*size/100; i+=0.01){
      float x = 100*-i;
      float y = -(wavyness*i*coefficient3*sin(i-1.05*tentacletime));
      float xold = x;
      x = (x*cos(facing)) - y*sin(facing);
      y = (y*cos(facing)) + xold*sin(facing);
      vertex(C.x+x,C.y+y);
    }
    endShape();
    
    //tentacle4 //coeficient= average -0.6
    beginShape();
    for(float i=0; i<HALF_PI*size/100; i+=0.01){
      float x = 100*-i;
      float y = -(wavyness*i*coefficient4*sin(i-1.05*tentacletime));
      float xold = x;
      x = (x*cos(facing)) - y*sin(facing);
      y = (y*cos(facing)) + xold*sin(facing);
      vertex(D.x+x,D.y+y);
    }
    endShape();
    
    
    //tentacle5 //coeficient= average -1
    beginShape();
    for(float i=0; i<HALF_PI*size/100; i+=0.01){
      float x = 100*-i;
      float y = -(wavyness*i*coefficient5*sin(i-1.05*tentacletime));
      float xold = x;
      x = (x*cos(facing)) - y*sin(facing);
      y = (y*cos(facing)) + xold*sin(facing);
      vertex(E.x+x,E.y+y);
    }
    endShape();
    
    
    tentacletime+=0.1;
  }
  
  
  boolean offscreen(){
    if ((pos.x>width+3*size)||(pos.x<-3*size)||(pos.y>height+3*size)||(pos.y<-3*size)){
      return true;
    }else{
      return false;
    }
  }
  
  
  
}
