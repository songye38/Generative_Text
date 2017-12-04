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
//GenerativeChar[] charArray;
GenerativeWord[] wordArray;
//GenerativeString[] textArray;


//-------------------- variable array to save loaded data----------------// 
//String[] dividedString;
String[] dividedWord;
//char[] dividedChar;


//------------------ initial parameters and declaration-----------------//
String filepath = "";


//-------------------- text output ----------------------//
boolean savePDF = false;

//--------------------- value for gui return values----------------//
int fontSize;
int fontTypeIndex;
String colorHexValue;
boolean btnStatus;
boolean taStatus;
int lineHeight; 


//하나의 텍스트를 기준으로 만들기 
void setup()
{
  size(1200,600);  //minimum height is 600
 // background(255,255,255);
  setupGUI();
}

void draw()
{
  background(255);
  fill(0);
  if(btnStatus==true) //input 버튼을 눌렀을 때 파일 선택창을 열기
  {
    selectInput("Select a file to process:", "fileSelected");
  }
  //내가 파일을 선택해서 filepath가 채워지면 그때 이 path를 바탕으로 텍스트를 로드하기 
  if(filepath!="")
  {
    loadTextByWord(loadText(filepath));
    initGenerativeWord(dividedWord);

    drawWordInArea();
    ta.setFont(createFont(getFontNameByIndex(fontTypeIndex),fontSize));
    ta.setColor(color(getColorByHex(colorHexValue)));
    ta.setLineHeight(lineHeight);
    ta.scroll(map(mouseY,0,height,0,1));
    println(map(mouseY,0,height,0,1));
  }
   btnStatus = false;
}


//-------------------- load text --------------------//
String loadText(String filename)
{
  String[] content = loadStrings(filename);
  String finalContent = content[0];
  return finalContent;
}

int loadTextByWord(String content)
{
  dividedWord = split(content,' ');
  return 1;
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

String getFontNameByIndex(int index)
{
  String[] fontList = PFont.list();
  String name = fontList[index];
  return name;
}

color getColorByHex(String hexValue)
{
  color rgb = hexToRgb(hexValue);
  return rgb;
}
color hexToRgb(String hexValue)
{
  String subString = hexValue.substring(3,9);
  //println(subString);
  color rgb = color(
            Integer.valueOf( subString.substring( 0, 2 ),16),
            Integer.valueOf( subString.substring( 2, 4 ),16),
            Integer.valueOf( subString.substring( 4, 6 ),16) );
 // println(rgb);
  return rgb;
}


void drawWordInArea()
{
  int length = dividedWord.length;
  String for_ta = "";
  for(int i=0; i<length; i++)
  {
    for_ta += wordArray[i].getWord();
  }
  ta.setText(for_ta);
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