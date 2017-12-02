

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
int[] symbolIndexArray;
char[] symbolChars;
int numOfSym = 0;
String stringResult;


//-------------------- variable array to save loaded data----------------// 

char[] dividedChar;
char[] dividedOriginalText;


//------------------ initial parameters and declaration-----------------//
String result_filepath = "";
String original_filepath = "";



//-------------------- text output ----------------------//
boolean savePDF = false;

//--------------------- value for tab1 gui return values----------------//
int fontSize;
int fontTypeIndex;
String colorHexValue;
boolean btnStatus = false;


//--------------------- value for tab2 gui return values----------------//
boolean tab2BtnStatus = false;
String resultSymbolString = "";
boolean tab2FinishStatus = false;




//하나의 텍스트를 기준으로 만들기 
void setup()
{
  size(1200,600);  //minimum height is 600
  background(255,255,255);
  //symbolArray = new CharSymbol[symNum];  //문장기호는 총 19개가 있다 (이미 확정된 것)
  symbolIndexArray = new int[100];  //일단 잠시동안만
  setupGUI();
}

void draw()
{
  background(255);
  fill(0);
  
  if(tab2BtnStatus) selectInput("Select a file to process:", "fileSelectedOriginal");
  
  if(tab2FinishStatus)
  {
    numOfSym = resultSymbolString.length();
  }
  if(original_filepath!="")
  {
    setupOriginalText(original_filepath);
    initSymbolClass();
    initSymbolIndex();
    mergeSymbols();
  }
  
  
  if(btnStatus==true)
  {
    selectInput("Select a file to process:", "fileSelected");
  }
  if(result_filepath!="")
  {
    loadTextByChar(loadText(result_filepath));  //일단은 텍스트를 로드하기 

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
   tab2BtnStatus = false;
   //mergeDoneStatus = false;
}

/*
//------------------variable for character symbols-----------------------//
CharSymbol[] symbolArray;
static final int symNum = 19;
int[] symbolIndexArray;
char[] symbolChars;
*/

void setupOriginalText(String filename)
{
  String[] a = loadStrings(filename);
  stringResult = a[0];
}

void initSymbolClass()
{
  symbolArray = new CharSymbol[numOfSym];
  for(int i=0; i<numOfSym; i++)
  {
    symbolArray[i] = new CharSymbol(resultSymbolString.charAt(i));
  }
}

void initSymbolIndex()
{
  symbolIndexArray = new int[numOfSym];
  int randomValue = 0;
  for(int i=0; i<numOfSym; i++)
  {
    randomValue = (int)random(0,stringResult.length());
    symbolIndexArray[i] = randomValue;
    //symbolArray[i].setIndex(randomValue);
  }
   Arrays.sort(symbolIndexArray);
   printArray(symbolIndexArray);
}
void mergeSymbols()
{
  //println(stringResult);
  String finalString = "";
  int startIndex =0;
  int endIndex = 0;
    for(int j=0; j<numOfSym; j++)
    {
      startIndex = endIndex;
      endIndex = symbolIndexArray[j];
      finalString += stringResult.substring(startIndex,endIndex);
      finalString += symbolArray[j].getChar();
    }
  println(finalString);
}

/*버튼을 눌러 텍스트를 담기 
* 어차피 substring으로 텍스트를 나눌 거니까 굳이 전체 string을 char로 나눌 필요는 없을 것 같다 
* 내가 make tab에서 입력한 문자기호들을 symbolArray에 담기 
* 이걸 많이 쓰니까 아예 내가 입력한 문자들의 개수를 변수에 담아두는 게 필요할 것 같다 numofSym;
* numofSym;만큼 symbolArray를 생성하기 
* symbolArray에 내가 tab2에서 입력한 문자 기호들을 하나씩 담기 //
* numofSym만큼 symbolIndexArray도 int배열을 생성해주기  //
* 위에서 받은 전체 문자열의 길이를 기준으로 random 값들을 생성하기
* symbolArray에 .setindex 함수를 이용해서 랜덤 인덱스 값들을 정해주기 
* arrays.sort를 통해서 오름차순으로 정렬하기  symbolIndexArray 이 배열 자체를 //
* substring을 통해 해당 인덱스까지의 문자열을 추출해서 전체 문자열에 붙여주기 
* 내가 아까 입력한 그 문자기호들을 하나씩 전체 문자열에 붙여주기 
*
*
*
*/

//substring을 만든다음에 이 substring들을 하나의 string으로 합치고 다시 하나의 문자열로 쪼갤까?


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
  dividedChar = new char[length];
  for(int i=0; i<length; i++)
  {
    dividedChar[i] = content.charAt(i);
  }
  return 1;
}

int loadOriginalTextByChar(String content)
{
  int length = content.length();
  dividedOriginalText = new char[length];
  for(int i=0; i<length; i++)
  {
    dividedOriginalText[i] = content.charAt(i);
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

// -------------------- key and mouse events ------------------------
void keyPressed()
{
  //save to pdf
  if(key=='p'||key=='P'){
    savePDF = true; 
  }
}


//-----------------------------------file input-----------------------------------
void fileSelectedOriginal(File selection)
{
  if(selection==null){
    println("window was closed or the user hit cancel");
  }
  else {
    original_filepath = selection.getAbsolutePath();
  }
}

void fileSelectedResult(File selection)
{
  if(selection==null){
    println("window was closed or the user hit cancel");
  }
  else {
    result_filepath = selection.getAbsolutePath();
  }
}

String timestamp() {
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", Calendar.getInstance());
}