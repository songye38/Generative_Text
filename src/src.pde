

// ---------------imports---------------------//
import processing.pdf.*;
import java.util.Calendar;



/* exploring text
*  f                 :text file input
*  p                 :save pdf
*  s                 :save png
*/

//글자와 단어 그리고 문장을 담을 배열들 
GenerativeChar[] charArray;
GenerativeWord[] wordArray;
GenerativeString[] textArray;


//-------------------- variable array to save loaded data----------------// 
String[] dividedString;
String[] dividedWord;
char[] dividedChar;


//------------------ initial parameters and declaration-----------------//
String filepath = "";


//-------------------- text output ----------------------//
boolean savePDF = false;


//하나의 텍스트를 기준으로 만들기 
void setup()
{
  size(1200,600);  //minimum height is 600
  background(255,255,255);
  setupGUI();
  ///frameRate(1);  
}

void draw()
{
  drawGUI();
  background(255);
  fill(0);
  if(filepath!="")
  {
    loadTextByString(loadText(filepath));
    loadTextByWord(loadText(filepath));
    loadTextByChar(loadText(filepath));
    
    initGenerativeString(dividedString);
    initGenerativeWord(dividedWord);
    initGenerativeChar(dividedChar);
    
    drawCharByLine(); //여기서 그려준다 
    
    //if (savePDF) {
    //println(savePDF);
    //beginRecord(PDF, timestamp()+".pdf");
    // }
     
    //if (savePDF) {
    //savePDF = false;
    //endRecord();
    //println("saving to pdf – done");
    // }
  }
}


//-------------------- load text --------------------//
String loadText(String filename)
{
  String[] content = loadStrings(filename);
  String finalContent = content[0];
  return finalContent;
}
 
 
//------------------from file to variable load data------------// 
int loadTextByString(String content)
{
  dividedString = split(content,'.');
  return 1;
}

int loadTextByWord(String content)
{
  dividedWord = split(content,' ');
  return 1;
}

int loadTextByChar(String content)
{
  int length = content.length();
  dividedChar = new char[length];
  for(int i=0; i<length; i++)
  {
    dividedChar[i] = content.charAt(i);
  }
  return 1;
}

//-------------------- init text / word / char ------------------------//
void initGenerativeString(String[] strings)
{
  int length = strings.length;
  textArray = new GenerativeString[length];
  for(int i=0; i<length; i++)
  {
    textArray[i] = new GenerativeString(strings[i]);
  }
}

void initGenerativeWord(String[] words)
{
  int length = words.length;
  wordArray = new GenerativeWord[length];
  for(int i=0; i<length; i++)
  {
    wordArray[i] = new GenerativeWord(words[i]);
  }
}

void initGenerativeChar(char[] chars)
{
  int length = chars.length;
  charArray = new GenerativeChar[length];
  for(int i=0; i<length; i++)
  {
    charArray[i] = new GenerativeChar(chars[i]);
  }
}

//------------------setboundingbox for string and draw text-----------------//
void setStringBoundingBox(String[] dividedString)
{
  int num = dividedString.length;
  for(int i=0; i<num; i++)
  {
    int randomX = int(random(0,width));
    int randomY = int(random(0,height));
    int endX = int(random(width/2,width));
    int endY = int(random(height/2,height));
    textArray[i].setBoundingBox(randomX,randomY,endX,endY);
  }
}

void drawString(int i)
{
    textArray[i].drawString();
}


//---------------------set position for char and draw char by line-----------------//
void setCharPos(int i)
{
    int randomX = int(random(10,width));
    int randomY = int(random(10,height));
    charArray[i].setPosX(randomX);
    charArray[i].setPosY(randomY);
}
void drawCharByLine()
{
  int length = dividedChar.length;
  int offsetY =20;
  float totalLength =0;
  for(int i=0; i<length; i++)
  {
    totalLength += charArray[i].getCharWidth();
    
    if(totalLength<width-20){
      charArray[i].drawChar(totalLength,offsetY);
    }
    else
    {
      offsetY +=(charArray[i].getFontSize())*2;
      totalLength = 0;
      charArray[i].drawChar(totalLength,offsetY); 
      //println(offsetY);
      //if(offsetY>height-(charArray[i].getFontSize())*2)
      // {
      //  offsetY = 20;
      //  charArray[i].setFontColor(100,20,100);
      //  charArray[i].drawChar(totalLength,offsetY); 
      //}
    }
  }
}
//int getTotalOffsetY()
//{
//  int length = dividedChar.length;
//  int offsetY =20;
//  float totalLength =0;
//  int totalOffset =0;
//  for(int i=0; i<length; i++)
//  {
//    totalLength += charArray[i].getCharWidth();
    
//    if(totalLength>width-20)
//    {
//      offsetY +=(charArray[i].getFontSize())*2;
      
//    }
//  }
//  return offsetY;
 
 
//}
//int getPageNum()
//{
//  int ypos = height-40;
//  int xpos = width/2;
//  int num = (getTotalOffsetY()/ypos);
//  //println(getTotalOffsetY());
//  //println(ypos);
//  return num;
  
//  //총 몇페이지에 나눠서 텍스트 전체를 표시할 수 있는가?
//  //height and offsetY 
//}
//void printPageNum()
//{
//  int content = getPageNum();
//  String c = str(content);
//  //char char_content = content.charAt(0);
//  text(c, width/2, height-40);
//}


/* 2017.11.22 
*
*/

//void drawStringWithinBox(String[] dividedString)
//{
//  int num = dividedString.length;
//  for(int i=0; i<num; i++)
//  {
//    int widthOfString = textArray[i].getNumOfCharsInString();
//    if(widthOfString>width)
//    {
//      textArray[i].
//    }
    
//  }
//}


// -------------------- key and mouse events ------------------------
void keyPressed()
{
  if(key=='f'||key=='F'){
    selectInput("Select a file to process:", "fileSelected");
  }
  //save to pdf
  if(key=='p'||key=='P'){
    savePDF = true; 
  }
}


//----------------------file input-----------------------------------
void fileSelected(File selection)
{
  if(selection==null){
    println("window was closed or the user hit cancel");
  }
  else {
    println(selection.getAbsolutePath());
    filepath = selection.getAbsolutePath();
  }
}

String timestamp() {
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", Calendar.getInstance());
}