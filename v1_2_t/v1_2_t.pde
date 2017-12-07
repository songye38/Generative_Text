

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
GenerativeString[] textOriginalArray;
String[] dividedOriginalText;

PrintWriter output;

static final int offsetX = 200;  //GUI의 width; 


//------------------variable for character symbols-----------------------//
CharSymbol[] symbolArray;
int[] symbolIndexArray;
char[] symbolChars;
int numOfSym = 0;
String stringResult;


//-------------------- variable array to save loaded data----------------// 

char[] dividedChar;
//char[] dividedOriginalText;


//------------------ initial parameters and declaration-----------------//
String result_filepath = "";
String original_filepath = "";



//-------------------- text output ----------------------//


//--------------------- value for tab1 gui return values----------------//
int fontSize;
int fontTypeIndex;
String colorHexValue;
boolean btnStatus = false;
boolean savePDF = false;
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
  background(255,255,255);
  setupGUI();
}

void draw()
{
  if(savePDF)
  {
    exportToPdf();
  }
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
    if(tab2ExportStatus&&mergeStatus)
    {
      exportToTxt(mergeSymbol_t());
    }
  }
 
  if(btnStatus==true)
  {
    selectInput("Select a file to process:", "fileSelectedResult");
  }
  if(result_filepath!="")
  {
    
    drawTextInArea(loadText(result_filepath));
    ta.setFont(createFont(getFontNameByIndex(fontTypeIndex),fontSize));
    ta.setColor(color(getColorByHex(colorHexValue)));
    ta.setLineHeight(lineHeight);
    ta.scroll(map(mouseY,0,height,0,1));
  }
  if(savePDF)
  {
    savePDF = false;
    println("end of make pdf file");
    endRecord();
  }
   btnStatus = false;
   tab2BtnStatus = false;
   mergeStatus = false;
}

//내가 tab2에서 가져온 그 파일을 처리하는 곳 
void setupOriginalText(String filename)
{
  String[] a = loadStrings(filename);
  stringResult = a[0];
  dividedOriginalText = split(stringResult,'.');
  int length = dividedOriginalText.length;
  textOriginalArray = new GenerativeString[length];
  for(int i=0; i<length; i++)
  {
    textOriginalArray[i] = new GenerativeString(dividedOriginalText[i]);
  } 
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
    randomValue = (int)random(0,dividedOriginalText.length);
    symbolIndexArray[i] = randomValue;
  }
   Arrays.sort(symbolIndexArray);
}

String mergeSymbol_t()
{
  String finalString = "";
  int length = dividedOriginalText.length;  
  
  for(int i=0; i<length; i++)
  {
    finalString += textOriginalArray[i].getText();
    for(int j=0; j<numOfSym; j++)
    {
      if(i==symbolIndexArray[j])
      {
        finalString += symbolArray[j].getChar();
      }
    }
  }
  return finalString;
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

void exportToTxt(String str)
{
  output = createWriter(timestamp()+".txt");
  output.println(str);
  output.flush();
  output.close();
}
void exportToPdf()
{
  beginRecord(PDF,timestamp()+".pdf");
}


//-------------------- load text --------------------//
String loadText(String filename)
{
  String[] content = loadStrings(filename);
  String finalContent = content[0];
  return finalContent;
}
 

//-------------------- init text / word / char ------------------------//

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

void drawTextInArea(String content)
{
  String for_ta = "";
  for_ta += content;
  ta.setText(for_ta);
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