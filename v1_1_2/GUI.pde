
//-----------------ControlP5------------------//
import controlP5.*;
import java.util.Map;
ControlP5 cp5;
Accordion accordion;
ListBox l;
ColorWheel cw;
Slider s;
Button btn;
Textarea ta;


void setupGUI() {
  
cp5 = new ControlP5(this);
  
  // group number 1, contains 2 bangs
  Group g1 = cp5.addGroup("type")
                .setBackgroundColor(color(0, 64))
                .setBackgroundHeight(150)
                ;

 l = cp5.addListBox("list")
        .setPosition(15,10)
        .setSize(130,130)
        .setItemHeight(20)
        .setBarHeight(10)
        .setColorBackground(color(255,255))
        .setColorActive(color(0))
        .setColorForeground(color(255,100,0))
        .moveTo(g1);
        ;
   l.getCaptionLabel().toUpperCase(true);
   l.getCaptionLabel().set("Font List");
   l.getCaptionLabel().setColor(0);
   
   String[] fontList = PFont.list();
  
  //요 부분에서 내 컴퓨터에서 사용 가능한폰트들의 리스트를 넣어주기 
  for (int i=0;i<fontList.length;i++) {
    l.addItem(fontList[i],fontList[i]);
    l.getItem(fontList[i]).put("color", new CColor().setBackground(0xffff0000).setBackground(0xffff8800));
  }
     
  // group number 2, contains a radiobutton
  Group g2 = cp5.addGroup("color")
                .setBackgroundColor(color(0, 64))
                .setBackgroundHeight(180)
                ;
                
   cw = cp5.addColorWheel("c", 15,10,150)
           .setRGB(color(0))
           .moveTo(g2);
  
  // group number 3, contains a bang and a slider
  Group g3 = cp5.addGroup("size")
                .setBackgroundColor(color(0, 64))
                .setBackgroundHeight(100)
                ;
  s = cp5.addSlider("fontSize")
         .setPosition(15,10)
         .setRange(5,50)
         .setValue(20)
         .moveTo(g3);
         
  Group g4 = cp5.addGroup("file")
                .setBackgroundColor(color(0,64))
                .setBackgroundHeight(100)
                ;
  btn = cp5.addButton("inputFile")
           .setPosition(10,10)
           .setSize(40,40)
           .moveTo(g4)
           ;


  // create a new accordion
  // add g1, g2, and g3 to the accordion.
  accordion = cp5.addAccordion("acc")
                 .setPosition(5,5)
                 .setWidth(180)
                 .addItem(g1)
                 .addItem(g2)
                 .addItem(g3)
                 .addItem(g4)
                 ;
  ta = cp5.addTextarea("txt")
          .setPosition(200,10)
          .setSize(width-220,height-20)
          .setLineHeight(20)
          .setFont(createFont("arial",12))
          .setColor(color(128))
          .setColorBackground(color(255,100))
          .setColorForeground(color(255,100))
          ;
  accordion.open(0,1,2,3);

  accordion.setCollapseMode(Accordion.MULTI);

}



void drawGUI() {
 
}

void controlEvent(ControlEvent theControlEvent) {
  if(theControlEvent.isFrom("fontSize")){
    int a =(int)theControlEvent.getController().getValue();
    fontSize = a;
  }
  if(theControlEvent.isFrom("list")){
    int index =(int)theControlEvent.getController().getValue();
    fontTypeIndex = index;

  }
  if(theControlEvent.isFrom("c")){
    int rgbInt = cp5.get(ColorWheel.class,"c").getRGB();
    String hexValue = String.format("#%06x",rgbInt);
    colorHexValue = hexValue;
  }
  if(theControlEvent.isFrom("inputFile")){
    taStatus = true;
    btnStatus = true;
    print("ta status");
    println(taStatus); //for check 
  }
}