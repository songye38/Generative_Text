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

//--------------------- value for gui return values----------------//
int fontSize;
int fontTypeIndex;
String colorHexValue;


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
    
    if(colorHexValue!=null)
    {
      setFontTypeToChar(fontTypeIndex);
     setFontColorToChar(colorHexValue);
     setFontSizeToChar(fontSize);
     
    drawCharByLine(); //여기서 그려준다 
    }
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
  println(subString);
  color rgb = color(
            Integer.valueOf( subString.substring( 0, 2 ),16),
            Integer.valueOf( subString.substring( 2, 4 ),16),
            Integer.valueOf( subString.substring( 4, 6 ),16) );
  println(rgb);
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
    }
  }
}

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

/* 
* String loadText(String filename);
* int loadTextByString(String content);
* int loadTextByWord(String content);
* int loadTextByChar(String content);
* void initGenerativeString(String[] strings)
* void initGenerativeWord(String[] words)
* void initGenerativeChar(char[] chars)
*
*
*
*
*/