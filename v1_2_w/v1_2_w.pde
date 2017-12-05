/*
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
import processing.pdf.*;
import java.util.Calendar;
import java.util.Map;

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


//--------------------- value for tab2 gui return values----------------//
boolean tab2BtnStatus = false;
String resultSymbolString = "";
boolean tab2FinishStatus = false;
boolean tab2ExportStatus =false;
boolean mergeStatus = false;


//하나의 텍스트를 기준으로 만들기 
void setup()
{
  size(1200,600);  //minimum height is 600
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
    //println(map(mouseY,0,height,0,1));
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
  //공백을 기준으로 단어를 나눴는데 다시 합칠때는 공백을 넣어서 합쳐야 될 것 같다 
  return 1;
}

void initGenerativeWord(String[] words)
{
  int length = words.length;
  wordArray = new GenerativeWord[length];
  for(int i=0; i<length; i++)
  {
    wordArray[i] = new GenerativeWord(words[i]+" ");
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
  color rgb = color(
            Integer.valueOf( subString.substring( 0, 2 ),16),
            Integer.valueOf( subString.substring( 2, 4 ),16),
            Integer.valueOf( subString.substring( 4, 6 ),16) );
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