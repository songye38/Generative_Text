/* done을 눌렀을 때 그래프가 그려지도록 해주기 
* 그래프의 각 바의 높이는 각 파일에 있는 문장의 개수로 해주기 
* 그러면 내가 일단 done이라는 버튼을 누르면 각 파일들에 있는 문장들을 각각 문장 단위로 쪼개야 한다 
* 내가 export를 눌러 내가 새롭게 만든 텍스트를 생성했을 때 내가 전에 그린 그래프들을 지워주기 
* 해당 파일명에 해당하는 파일들을 로드하기 
* 이때 여러문단들을 하나로 합쳐주기 
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
char[] dividedOriginalText;


//------------------ initial parameters and declaration-----------------//
String result_filepath = "";
String original_filepath = "";


//--------------------- value for tab1 gui return values----------------//
int fontSize;
int fontTypeIndex;
String colorHexValue;
boolean btnStatus = false;


//--------------------- value for tab2 gui return values----------------//
boolean tab2BtnStatus = false;
String resultSymbolString = "";
boolean tab2FinishStatus = false;
boolean tab2ExportStatus =false;
boolean mergeStatus = false;
boolean taStatus;
int lineHeight; 
boolean saveOneFrame = false;

//----------------------------이번 버전에서 새롭게 추가된 변수들------------------------//
int numOfSelectedFiles = 0;
//0번 인덱스에에는 전체 파일 경로
//1번 인덱스에는 파일의 이름을 저장
String[][] selectedFileNames;        //선택된 파일들의 경로를 담는 배열 
final int NUM_OF_FILES = 100;        //최대 선택할 수 있는 파일의 개수//최대 선택할 수 있는 파일의 개수
boolean isfileSelectDone = false;
String[][] loadedSelectedFiles;      //선택된 파일들에 담겨져 있는 내용들을 담는 변수 
int numOfSentence[][];   //각각에 파일에 담겨 있는 문장들의 개수를 담는 변수 
boolean[][] buttonStatusArray;
String[][] splittedFiles;
boolean isMakeButton = false;
String btnClickedFileName = "";
String chosenString = "";

//하나의 텍스트를 기준으로 만들기 
void setup()
{
  size(1200,600);  //minimum height is 600
  background(255,255,255);
  selectedFileNames = new String[NUM_OF_FILES][2];
  loadedSelectedFiles = new String[NUM_OF_FILES][1];
  numOfSentence = new int[NUM_OF_FILES][1];
  splittedFiles = new String[NUM_OF_FILES][1000];
  buttonStatusArray = new boolean[NUM_OF_FILES][1];
  for(int i=0; i<NUM_OF_FILES; i++)
  {
    buttonStatusArray[i][0] = false;
  }
  setupGUI();
}

void draw()
{
   background(255);
  if(saveOneFrame == true) {
    saveFrame(timestamp()+".png");
    saveOneFrame = false;
  }
  
  //파일 선택 버튼이 눌렸다면!!!!
  if(tab2BtnStatus) selectInput("Select a file to process:", "fileSelectedOriginal");
  
  //파일 선택하기 종료 버튼이 눌렸다면!!!!
  //하나하나의 파일 별로 배열을 만들어주기 -> 이 배열에 
  if(isfileSelectDone)
  {
    for(int i=0; i<numOfSelectedFiles; i++)
    {
      loadedSelectedFiles[i][0] = setupSelectedFiles(selectedFileNames[i][0]);
      numOfSentence[i][0] = getNumOfSentence(loadedSelectedFiles[i][0]);
      loadFilesIntoArray(loadedSelectedFiles[i][0],i);
    }
  }
  if(isMakeButton) makeButtons(numOfSelectedFiles);
  
  int index = processClickedFileName();
  chosenString = splittedFiles[index][0];
  
  drawGUI();
  
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
      exportToTxt(mergeSymbols());
    }
  }
  if(btnStatus==true)
  {
    selectInput("Select a file to process:", "fileSelectedResult");
  }
  if(result_filepath!="")
  {
    loadTextByChar(loadText(result_filepath));  //일단은 텍스트를 로드하기 

    initGenerativeChar(dividedChar);
    
    drawCharInArea();
    ta.setFont(createFont(getFontNameByIndex(fontTypeIndex),fontSize));
    ta.setColor(color(getColorByHex(colorHexValue)));
    ta.setLineHeight(lineHeight);
    ta.scroll(map(mouseY,0,height,0,1));
  }
   btnStatus = false;
   tab2BtnStatus = false;
   mergeStatus = false;
   isMakeButton = false;
}

void setupOriginalText(String filename)
{
  String[] a = loadStrings(filename);
  int length = a.length;
  for(int i=0; i<length; i++)
  {
    stringResult += a[i];
  }
}
//filename으로 가져와서 그냥 하나의 문단으로 만들기 
String setupSelectedFiles(String filename)
{
  String[] a = loadStrings(filename);
  String tempString = "";
  int length = a.length;
  for(int i=0; i<length; i++)
  {
    tempString += a[i];
  }
  return tempString;
}
void loadFilesIntoArray(String str, int index)
{
  String[] tempstr = split(str,'.');
  int len = tempstr.length;
  for(int i=0; i<len; i++)
  {
    splittedFiles[index][i] = tempstr[i];
  }
}
int processClickedFileName()
{
  int index =0;
  for(int i=0; i<numOfSelectedFiles; i++)
  {
    if(selectedFileNames[i][1].equals(btnClickedFileName))
    {
      index =i;
    }
  }
  return index;
}

int getNumOfSentence(String str)
{
  String[] tempString = split(str,'.');
  return tempString.length;
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
  }
   Arrays.sort(symbolIndexArray);
}
String mergeSymbols()
{
  String finalString = "";
  int startIndex =0;
  int endIndex = 0;
  int last = stringResult.length();
    for(int j=0; j<numOfSym; j++)
    {
      startIndex = endIndex;
      endIndex = symbolIndexArray[j];
      finalString += stringResult.substring(startIndex,endIndex);
      finalString += symbolArray[j].getChar();
    }
     if(endIndex!=last)
      {
        endIndex = last;
        finalString += stringResult.substring(startIndex,endIndex);
      }
  return finalString;
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

void drawCharInArea()
{
  //여기서는 위치값을 전해줄 필요없이 그냥 char들을 넘겨주면 된다 
   int length = dividedChar.length;
   String for_ta = "";
   for(int i=0; i<length; i++)
   {
     for_ta += charArray[i].getChar();
   }
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
    selectedFileNames[numOfSelectedFiles][0] = original_filepath;
    selectedFileNames[numOfSelectedFiles][1] = selection.getName();
    tab2g1list.addItem(selectedFileNames[numOfSelectedFiles][1],selectedFileNames[numOfSelectedFiles]);
    tab2g1list.getItem(selectedFileNames[numOfSelectedFiles][1]).put("color", new CColor().setBackground(0xffff0000).setBackground(0xffff8800));
    numOfSelectedFiles++;  
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