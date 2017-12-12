
// ---------------imports---------------------//
import controlP5.*;
import java.util.Map;
import java.util.Arrays;
import processing.pdf.*;
import java.util.Calendar;


//글자와 단어 그리고 문장을 담을 배열들 
GenerativeChar[] charArray;

PrintWriter output;

static final int offsetX = 200;  //GUI의 width; 

//-------------------- variable array to save loaded data----------------// 

char[] dividedChar;

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
int[][] readFileIndex;
boolean isBtnSelected = false;
String finalText ="";
boolean isReset = false;
final int MAX_STR_IN_FILE =1000;
boolean autoStatus = false;

//하나의 텍스트를 기준으로 만들기 
void setup()
{
  size(1200,600);  //minimum height is 600
  background(255,255,255);
  selectedFileNames = new String[NUM_OF_FILES][2];
  loadedSelectedFiles = new String[NUM_OF_FILES][1];
  numOfSentence = new int[NUM_OF_FILES][1];
  splittedFiles = new String[NUM_OF_FILES][MAX_STR_IN_FILE];
  buttonStatusArray = new boolean[NUM_OF_FILES][1];
  readFileIndex = new int[NUM_OF_FILES][1];
  for(int i=0; i<NUM_OF_FILES; i++)
  {
    buttonStatusArray[i][0] = false;
    readFileIndex[i][0] = 0;
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
    tab2g1btn.hide();
    tab2g1btn2.hide();
    tab2g3btn1.hide();
    tab2g1auto.show();
    for(int i=0; i<numOfSelectedFiles; i++)
    {
      loadedSelectedFiles[i][0] = setupSelectedFiles(selectedFileNames[i][0]);
      numOfSentence[i][0] = getNumOfSentence(loadedSelectedFiles[i][0]);
      loadFilesIntoArray(loadedSelectedFiles[i][0],i);
    }
  }
  if(isMakeButton) makeButtons(numOfSelectedFiles);
  for(int i=0; i<numOfSelectedFiles; i++)
  {
    if(btnClickedFileName==selectedFileNames[i][1])
    {
      isBtnSelected = true;
    }
  }
  //내가 버튼을 하나씩 눌러서 각각의 텍스트를 합치는 곳 
  if(isBtnSelected)
  {
      int index = processClickedFileName();
      int i = readFileIndex[index][0];
      chosenString = splittedFiles[index][i];
      finalText += chosenString;
      readFileIndex[index][0]++;
      isBtnSelected  = false;
  }
  //오토 토글을 클릭했을 때
  //if(autoStatus)
  //{
  //   String thisString = "";
  //  //int index = numOfSelectedFiles;
  //  int randomIndex = int(random(0,numOfSelectedFiles));
  //  int i = readFileIndex[randomIndex][0];
  //  thisString = splittedFiles[randomIndex][i];
  //  finalText += thisString;
  //  readFileIndex[randomIndex][0]++;
  //}
  
  drawGUI();
  
  //finish를 눌러서 선택된 파일들이 담긴 배열을 초기화시켜주기 ..
  if(tab2FinishStatus)
  {
    tab2g1btn.show();
    tab2g1btn2.show();
    tab2g3btn1.show();
    tab2g1list.clear();
    tab2g1auto.hide();
    hideButtons(numOfSelectedFiles);
    resetFileRelatedArray();
    tab2g3btn1.setColorBackground(color(0,255,0));
    isfileSelectDone = false;
    
  }
  if(tab2ExportStatus)
  {
    exportToTxt(finalText);
    tab2g3btn1.hide();
    tab2ExportStatus = false;
    finalText = "";
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
   btnClickedFileName = "";
   tab2FinishStatus = false;
}

void resetFileRelatedArray()
{
  for(int i=0; i<numOfSelectedFiles; i++)
  {
    selectedFileNames[i][0] = null;
    selectedFileNames[i][1] = null;
    loadedSelectedFiles[i][0] ="";
    resetSplittedFiles(i, numOfSentence[i][0]);
    numOfSentence[i][0] =0;
    loadFilesIntoArray(loadedSelectedFiles[i][0],i);
  }
  numOfSelectedFiles =0;
}  

//이렇게 1000개까지 지우는건 진짜 불필요한 일인데......
void resetSplittedFiles(int index, int length)
{
  for(int i=0; i<length; i++)
  {
    splittedFiles[index][i] = "";
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