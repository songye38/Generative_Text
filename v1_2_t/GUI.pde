
//-----------------ControlP5------------------//

ControlP5 cp5;
Tab t1;
Tab t2;
PFont font;

//---------------------------------variable for tab1----------------------------------//
Accordion accordion1;
ListBox l;
ColorWheel cw;
Slider s;
Button btn;
Button pdfBtn;
//두개 추가된 것 
Textarea ta;
Slider lh;



//---------------------------------variable for tab2----------------------------------//
Button tab2g1btn;    //file input button
Textfield tab2g2field;   
Button tab2g2btn1;       //save button
Button tab2g2btn2;       //clear button
Button tab2g3btn1;
Button tab2g3btn2;
Accordion accordion2;


void setupGUI() {
  
//----------------------------basic setup----------------------------//
 cp5 = new ControlP5(this);
 font = createFont("arial",20);
 

//------------------------add two tabs-----------------------------//

  t1 = cp5.getTab("result")
          .activateEvent(true)
          .setLabel("result text")
          .setId(0)
          ;
  t2 = cp5.getTab("make")
          .activateEvent(true)
          .setLabel("make text")
          .setId(1)
          ;
  
//----------------------add group1 and add ListBox to g1---------------------//
  Group g1 = cp5.addGroup("type")
                .setBackgroundColor(color(0, 64))
                .setBackgroundHeight(150)
                ;
  //첫번째로 폰트를 선택할 리스트를 추가해주기 
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
     
//----------------------add group2 and add ColorWheel to g2---------------------//
  Group g2 = cp5.addGroup("color")
                .setBackgroundColor(color(0, 64))
                .setBackgroundHeight(180)
                ;
     
   //폰트 컬러 선택할 컬러 휠 추가해주기            
   cw = cp5.addColorWheel("c", 15,10,150)
           .setRGB(color(0))
           .moveTo(g2);
  
//----------------------add group3 and add Slider to g3---------------------//
  Group g3 = cp5.addGroup("size")
                .setBackgroundColor(color(0, 64))
                .setBackgroundHeight(100)
                ;
  //폰트 크기를 조절할 슬라이더 추가해주기              
  s = cp5.addSlider("fontSize")
         .setPosition(15,10)
         .setRange(5,50)
         .setValue(20)
         .moveTo(g3);
  lh = cp5.addSlider("lineHeight")
          .setPosition(15,30)
          .setRange(20,100)
          .setValue(20)
          .moveTo(g3)
          ;
//----------------------add group4 and add two Buttons to g4---------------------//     
  Group g4 = cp5.addGroup("file")
                .setBackgroundColor(color(0,64))
                .setBackgroundHeight(100)
                ;
  btn = cp5.addButton("inputFile")
           .setPosition(10,10)
           .setSize(40,40)
           .moveTo(g4)
           ;
  pdfBtn = cp5.addButton("exportPng")
              .setPosition(60,10)
              .setSize(40,40)
              .moveTo(g4)
              ;

//---------------------create tab1's accordion------------------------//
  // create a new accordion
  // add g1, g2, and g3 to the accordion.
  accordion1 = cp5.addAccordion("acc")
                 .setPosition(5,20)
                 .setWidth(180)
                 .addItem(g1)
                 .addItem(g2)
                 .addItem(g3)
                 .addItem(g4)
                 .moveTo("result")
                 ;
 ta = cp5.addTextarea("txt")
          .setPosition(200,10)
          .setSize(width-220,height-20)
          .setLineHeight(20)
          .setFont(createFont("arial",12))
          .setColor(color(0))
          .setColorBackground(color(255,100))
          .setColorForeground(color(255,0,0))
          .showScrollbar()
          .moveTo("result")
          ;
//----------------------add tab2 group1 and add Button to g1---------------------// 
  Group tab2g1 = cp5.addGroup("filechoose")
                .setBackgroundColor(color(0, 64))
                .setBackgroundHeight(150)
                ;
  tab2g1btn = cp5.addButton("File")
                 .setPosition(10,10)
                 .setSize(40,40)
                 .moveTo(tab2g1)
                 ;
//----------------------add group2 and add textFileds / two buttons to g2---------------------//                 
  Group tab2g2 = cp5.addGroup("addsymbol")
                .setBackgroundColor(color(0, 64))
                .setBackgroundHeight(150)
                ;
  
  tab2g2field = cp5.addTextfield("input")
                   .setPosition(10,20)
                   .setSize(150,40)
                   .setFont(font)
                   .setFocus(true)
                   .setColor(color(255))
                   .moveTo(tab2g2)
                   ;
  tab2g2btn1 = cp5.addButton("enter")
                  .setPosition(10,100)
                  .setSize(40,40)
                  .moveTo(tab2g2)
                  ;
  tab2g2btn2 = cp5.addButton("clear")
                  .setPosition(60,100)
                  .setSize(40,40)
                  .moveTo(tab2g2)
                  ;
//----------------------add group3 and add two Buttons to g1---------------------//              
  Group tab2g3 = cp5.addGroup("textexport")
                .setBackgroundColor(color(0, 64))
                .setBackgroundHeight(150)
                ;
  tab2g3btn1 = cp5.addButton("export")
                 .setPosition(10,10)
                 .setSize(40,40)
                 .moveTo(tab2g3);
                 
  tab2g3btn2 = cp5.addButton("finish")
                 .setPosition(60,10)
                 .setSize(40,40)
                 .moveTo(tab2g3);
                 
//----------------------add accordion to tab2---------------------//             
  accordion2 = cp5.addAccordion("acc2")
                 .setPosition(5,20)
                 .setWidth(180)
                 .addItem(tab2g1)
                 .addItem(tab2g2)
                 .addItem(tab2g3)
                 .moveTo("make")
                 ;
     
  accordion1.open(0,1,2,3);
  accordion1.setCollapseMode(Accordion.MULTI);
  
  accordion2.open(0,1,2);
  accordion2.setCollapseMode(Accordion.MULTI);
}

void drawGUI() {
 
}

void controlEvent(ControlEvent theControlEvent) {
  
//------------------------- controller check for tab1----------------------------//
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
    btnStatus = true;
  }
  if(theControlEvent.isFrom("lineHeight")){
    int t =(int)theControlEvent.getController().getValue();
    lineHeight = t;
  }
  if(theControlEvent.isFrom("exportPng")){
    saveOneFrame = true;
  }
//------------------------- controller check for tab2----------------------------//
  if(theControlEvent.isFrom("File")){
    tab2BtnStatus = true;
    //println(tab2BtnStatus);
  }
  if(theControlEvent.isFrom("finish")){
    tab2FinishStatus = true;
  }
  if(theControlEvent.isFrom("export")){
    tab2ExportStatus = true;
    mergeStatus = true;
  }
}

public void clear() {
  cp5.get(Textfield.class,"input").clear();
}
public void input(String theText) {
  //println("a textfield event for controller 'input' : "+theText);
  resultSymbolString += theText;
}