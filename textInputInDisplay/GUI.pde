
void setupGUI()
{
  widthOfBtn = width/3;
  heightOfBtn = height/3;
  
  startX = 0;
  startY = 0;
  
  plusX =0;
  plusY =0;
  
  noStroke();
  cp5 = new ControlP5(this);
  
  //------------------------ add 9 buttons----------------//
  // create a new button with name 'buttonA'
  cp5.addButton("file1")
     .setValue(0)
     .setPosition(startX+plusX,startY+plusY)
     .setSize(widthOfBtn,heightOfBtn)
     .setColorBackground(color(255,0,0))
     ;
     
     
  plusX += widthOfBtn;
  
  // and add another 2 buttons
  cp5.addButton("file2")
     .setValue(100)
     .setPosition(startX+plusX,startY+plusY)
     .setSize(widthOfBtn,heightOfBtn)
     .setColorBackground(color(255,255,0))
     ;
     
     
  plusX += widthOfBtn;
  
  cp5.addButton("file3")
     .setPosition(startX+plusX,startY+plusY)
     .setSize(widthOfBtn,heightOfBtn)
     .setValue(0)
     .setColorBackground(color(0,158,184))
     ;
     
    plusX =0;
    startY += heightOfBtn;
  //두번째 줄
  cp5.addButton("file4")
     .setValue(0)
     .setPosition(startX+plusX,startY+plusY)
     .setSize(widthOfBtn,heightOfBtn)
     .setColorBackground(color(255,115,0))
     ;
     
     
    plusX += widthOfBtn; 
  
  // and add another 2 buttons
  cp5.addButton("file5")
     .setValue(100)
     .setPosition(startX+plusX,startY+plusY)
    .setSize(widthOfBtn,heightOfBtn)
    .setColorBackground(color(0,136,55))
    ;
    
    plusX += widthOfBtn; 
  cp5.addButton("file6")
     .setPosition(startX+plusX,startY+plusY)
    .setSize(widthOfBtn,heightOfBtn)
     .setValue(0)
     .setColorBackground(color(74,1,125))
     ;
     
     plusX = 0;
     startY = heightOfBtn * 2;
     
  //세번째 줄
  cp5.addButton("file7")
     .setValue(0)
     .setPosition(startX+plusX,startY+plusY)
    .setSize(widthOfBtn,heightOfBtn)
    .setColorBackground(color(255,179,0))
    ;
    
  plusX += widthOfBtn; 
  // and add another 2 buttons
  cp5.addButton("file8")
     .setValue(100)
     .setPosition(startX+plusX,startY+plusY)
    .setSize(widthOfBtn,heightOfBtn)
    .setColorBackground(color(115,199,166))
    ;
    
   plusX += widthOfBtn; 
  cp5.addButton("file9")
     .setPosition(startX+plusX,startY+plusY)
     .setSize(widthOfBtn,heightOfBtn)
     .setValue(0)
     .setColorBackground(color(176,1,76))
     ;
}

void drawGUI()
{
  background(myColor);
  myColor = lerpColor(c1,c2,n);
  n += (1-n)* 0.1; 
}

public void controlEvent(ControlEvent theEvent) {
  println(theEvent.getController().getName());
  n = 0;
}

// function colorA will receive changes from 
// controller with name colorA
public void colorA(int theValue) {
  println("a button event from colorA: "+theValue);
  c1 = c2;
  c2 = color(0,160,100);
}

// function colorB will receive changes from 
// controller with name colorB
public void colorB(int theValue) {
  println("a button event from colorB: "+theValue);
  c1 = c2;
  c2 = color(150,0,0);
}

// function colorC will receive changes from 
// controller with name colorC
public void colorC(int theValue) {
  println("a button event from colorC: "+theValue);
  c1 = c2;
  c2 = color(255,255,0);
}

public void play(int theValue) {
  println("a button event from buttonB: "+theValue);
  c1 = c2;
  c2 = color(0,0,0);
}