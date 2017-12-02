

/* 파일을 인풋 받고 하는 과정을 좀 더 매끄럽게 만들어보기
//아마 많은 boolean값들을 두고 이 값들이 true일때만 실행되도록 만들어야 될것 같다
//controlp5를 통해서 파일을 입력받는것도 왠지 필요할것 같다
* - 어디서 글을 가져올 것인가?
* 1. choose text from file
* 2. choose text from news
* 3. choose text from evernote (java api 이용)
* 4. choose text from trello
* 5. choose text from wiki 

* - 가져온 글을 어떻게 합칠 것인가 -> 어떻게 텍스트를 만들 것인가?
* - 분야별로 합치기?

* - 가져온 글에서 내가 좀 더 수정할 수 있는 방법들을 생각해보기 
*/
// ---------------imports---------------------//
import controlP5.*;
import java.util.Map;
import java.util.Arrays;
import processing.pdf.*;
import java.util.Calendar;



/* exploring text
*  f                 :text file input
*  p                 :save pdf
*  s                 :save png
*/

//글자와 단어 그리고 문장을 담을 배열들 
GenerativeChar[] charArray;



static final int offsetX = 200;  //GUI의 width; 


//------------------variable for character symbols-----------------------//
CharSymbol[] symbolArray;
static final int symNum = 19;
int[] symbolIndexArray;


//-------------------- variable array to save loaded data----------------// 

char[] dividedChar;


//------------------ initial parameters and declaration-----------------//
String filepath = "";


//-------------------- text output ----------------------//
boolean savePDF = false;

//--------------------- value for gui return values----------------//
int fontSize;
int fontTypeIndex;
String colorHexValue;
boolean btnStatus = false;
boolean mergeDoneStatus = false;

//하나의 텍스트를 기준으로 만들기 
void setup()
{
  size(1200,600);  //minimum height is 600
  background(255,255,255);
  symbolArray = new CharSymbol[symNum];  //문장기호는 총 19개가 있다 (이미 확정된 것)
  symbolIndexArray = new int[symNum];
  initGenerativeSymbols();
  setupGUI();
}

void draw()
{
  background(255);
  fill(0);
  
  if(btnStatus==true)
  {
    selectInput("Select a file to process:", "fileSelected");
  }
  if(filepath!="")
  {
    loadTextByChar(loadText(filepath));  //일단은 텍스트를 로드하기 
    
    if(mergeDoneStatus==true)
    { 
      initSymbolsIndex();
      initSymbolIndexArray();
      mergeTextnSymbol();
    }
    
    initGenerativeChar(dividedChar);
    
    if(colorHexValue!=null)
    {
      setFontTypeToChar(fontTypeIndex);
     setFontColorToChar(colorHexValue);
     setFontSizeToChar(fontSize);
     
    drawCharByLine(); //여기서 그려준다 
    }
  }
   btnStatus = false;
   mergeDoneStatus = false;
}


//-------------------- load text --------------------//
String loadText(String filename)
{
  String[] content = loadStrings(filename);
  String finalContent = content[0];
  return finalContent;
}
 
//------------------from file to variable load data------------// 

int loadTextByChar(String content)
{
  int length = content.length();
  int total = length + symNum;
  dividedChar = new char[total];
  for(int i=0; i<length; i++)
  {
    dividedChar[i] = content.charAt(i);
  }
  for(int j = length; j<total; j++)
  {
    dividedChar[j] = '0';
  }
  return 1;
}

//-------------------- init text / word / char ------------------------//

void initGenerativeChar(char[] chars)
{
  int length = chars.length;
  charArray = new GenerativeChar[length];
  for(int i=0; i<length; i++)
  {
    charArray[i] = new GenerativeChar(chars[i]);
  }
}

void initGenerativeSymbols()
{
  symbolArray[0] = new CharSymbol('{');
  symbolArray[1] = new CharSymbol('[');
  symbolArray[2] = new CharSymbol(']');
  symbolArray[3] = new CharSymbol(':');
  symbolArray[4] = new CharSymbol('-');
  symbolArray[5] = new CharSymbol('_');
  symbolArray[6] = new CharSymbol('!');
  symbolArray[7] = new CharSymbol('-');
  symbolArray[8] = new CharSymbol('(');
  symbolArray[9] = new CharSymbol(')');
  symbolArray[10] = new CharSymbol('?');
  symbolArray[11] = new CharSymbol('/');
  symbolArray[12] = new CharSymbol(',');
  symbolArray[13] = new CharSymbol(';');
  symbolArray[14] = new CharSymbol('"');
  symbolArray[15] = new CharSymbol('{');
  symbolArray[16] = new CharSymbol('}');
  symbolArray[17] = new CharSymbol('|');
  symbolArray[18] = new CharSymbol('~');
}


void setFontSizeToChar(int size)
{
  int num = charArray.length;
  for(int i=0; i<num; i++)
  {
    charArray[i].setFontSize(size);
  }
}

void setFontTypeToChar(int index)
{
  int num = charArray.length;
  for(int i=0; i<num; i++)
  {
    charArray[i].setFont(index);
  }
}

void setFontColorToChar(String hexValue)
{
  color rgb = hexToRgb(hexValue);
  int num = charArray.length;
  for(int i=0; i<num; i++)
  {
    charArray[i].setFontColor(rgb);
  }
}

color hexToRgb(String hexValue)
{
  String subString = hexValue.substring(3,9);
  //println(subString);
  color rgb = color(
            Integer.valueOf( subString.substring( 0, 2 ),16),
            Integer.valueOf( subString.substring( 2, 4 ),16),
            Integer.valueOf( subString.substring( 4, 6 ),16) );
  //println(rgb);
  return rgb;
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
  float totalLength =offsetX;
  for(int i=0; i<length; i++)
  {
    totalLength += charArray[i].getCharWidth();
    
    if(totalLength<width-20){
      charArray[i].drawChar(totalLength,offsetY);
    }
    else
    {
      offsetY +=(charArray[i].getFontSize())*2;
      totalLength = offsetX;
      charArray[i].drawChar(totalLength,offsetY); 
    }
  }
}

//단어의 개수를 기준으로 각 기호들의 위치를 랜덤으로 정해주기 
void initSymbolsIndex()
{
  int length = dividedChar.length;
  int randomValue;
  //GenerativeChar 배열의 길이를 가지고 
  for(int i=0; i<symNum; i++)
  {
    randomValue = (int)random(length);
    symbolArray[i].setIndex(randomValue);
  }
}

//charSymbol의 getIndex()를 이용하여 symbolIndexArray를 초기화해주기 
//이 값을 바탕으로 원래 GenerativeChar 배열을 다시 초기화 해줄 예정 
void initSymbolIndexArray()
{
  for(int i=0; i<symNum; i++)
  {
    symbolIndexArray[i] = symbolArray[i].getIndex();
  }
  //여기서 이 배열 자체를 오름차순으로 만들어준다 
  Arrays.sort(symbolIndexArray);
}

void mergeTextWithSymbol()
{
  println("start merge test");
  //텍스트 로드 -> 텍스트 합치기 -> init
  int length = dividedChar.length;
  int index =0;
  for(int i=0; i<symNum; i++)
  {
    index = symbolIndexArray[i];
    for(int j=length-symNum; j>index; j--)
    {
      dividedChar[j+1] = dividedChar[j];
    }
    dividedChar[index] = symbolArray[i].getChar();
  }
  
  println("done merge test");
}

//이런식으로 합치지 말고 다른식으로 한번 합쳐보자 

void mergeTextnSymbol()
{
  int length = dividedChar.length;
  int index = 0;
  for(int i=0; i<length; i++)
  {
    for(int j=0; j<symNum; j++)
    {
      index = symbolIndexArray[j];
      char remove = dividedChar[index];
      dividedChar[index] =  symbolArray[j].getChar();
      dividedChar[index+1] = remove;
    }
  }
}



// -------------------- key and mouse events ------------------------
void keyPressed()
{
  //if(key=='f'||key=='F'){
  //  selectInput("Select a file to process:", "fileSelected");
  //}
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