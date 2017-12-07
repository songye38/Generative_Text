

/* 가장 핵심적인 문제 
* 우리는 이제 textarea를 통해서 그냥 전체 텍스트를 통으로 textarea로 넘길 것이다 -> 근데 굳이 generativeword로 나누어서 할 필요가 있나
* 그러니까 make text tab에서 파일을 가져올 때 이 파일 마저도 굳이 클래스에 담을 필요는 없을 것 같다 
* 필요한 건 처음 add symbol탭에서 파일을 export하고 그걸 읽어들일 때 이때 이 단어들을 generative word 객체로 만드는 게 필요할 것 같다 
*/


// ---------------imports---------------------//
import controlP5.*;
import processing.pdf.*;
import java.util.Calendar;
import java.util.Map;
import java.util.Arrays;


//글자와 단어 그리고 문장을 담을 배열들 
GenerativeWord[] wordSymbolArray;

//------------------variable for character symbols-----------------------//
CharSymbol[] symbolArray;
int[] symbolIndexArray;
char[] symbolChars;
int numOfSym = 0;
String stringResult;



//-------------------- variable array to save loaded data----------------// 

String[] dividedOriginalWord;  //내가 export를 해서 만들어진 파일 


//------------------ initial parameters and declaration-----------------//
String result_filepath = "";
String original_filepath = "";


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

PrintWriter output;


//하나의 텍스트를 기준으로 만들기 
void setup()
{
  size(1200,600);  //minimum height is 600
  setupGUI();
}

void draw()
{
  background(255);
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
  if(btnStatus==true) //input 버튼을 눌렀을 때 파일 선택창을 열기
  {
    selectInput("Select a file to process:", "fileSelectedResult");
  }
  //내가 파일을 선택해서 filepath가 채워지면 그때 이 path를 바탕으로 텍스트를 로드하기 
  if(result_filepath!="")
  {
   
    drawWordInArea(loadText(result_filepath));
    ta.setFont(createFont(getFontNameByIndex(fontTypeIndex),fontSize));
    ta.setColor(color(getColorByHex(colorHexValue)));
    ta.setLineHeight(lineHeight);
    ta.scroll(map(mouseY,0,height,0,1));
  }
   btnStatus = false;
   tab2BtnStatus = false;
   mergeStatus = false;
}


//-------------------- load text --------------------//
String loadText(String filename)
{
  String[] content = loadStrings(filename);
  String finalContent = content[0];
  return finalContent;
}

void setupOriginalText(String filename)
{
  String[] a = loadStrings(filename);
  stringResult = a[0];
  dividedOriginalWord = split(stringResult,' ');
  int length = dividedOriginalWord.length;
  wordSymbolArray = new GenerativeWord[length];
  for(int i=0; i<length; i++)
  {
    wordSymbolArray[i] = new GenerativeWord(dividedOriginalWord[i]+" ");
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

void exportToTxt(String str)
{
  output = createWriter(timestamp()+".txt");
  output.println(str);
  output.flush();
  output.close();
}

//가져온 텍스트 파일을 굳이 generativeWord클래스에 담아서 출력할 필요가 있을까?
void drawWordInArea(String content)
{
  //int length = dividedWord.length;
  String for_ta = "";
  for_ta += content;
  //for(int i=0; i<length; i++)
  //{
  //  for_ta += wordArray[i].getWord();
  //}
  ta.setText(for_ta);
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
    randomValue = (int)random(0,dividedOriginalWord.length);
    symbolIndexArray[i] = randomValue;
  }
   Arrays.sort(symbolIndexArray);
}


String mergeSymbol_t()
{
  String finalString = "";
  int length = dividedOriginalWord.length;  
  
  for(int i=0; i<length; i++)
  {
    finalString += wordSymbolArray[i].getWord();
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

//----------------------file input-----------------------------------
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