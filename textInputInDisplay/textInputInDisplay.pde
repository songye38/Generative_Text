
/* 여러개의 파일들을 입력받아서 하나의 텍스트 파일로 만드는 프로그램 
*  앞으로 만들 프로그램 
*  1. 다른 사이트에 있는 데이터들을 api를 통해 가져오기 
*  2. 기사 같은 것들을 수집하기 
*  3. 아마 이렇게 수집한 텍스트들을 한 곳에서 정리할 수 있는 어떤 중심된 프로그램이 필요할 것 같다
*  4. 한글 말고 영어로 된 데이터들을 중간중간에 넣어보면 어떨까?
*  5. 다른 여러나라의 언어들을 단어나 문자 문자열의 형태로 집어넣어보기 
*/

//------------------ setup for controlP5------------------------//

import controlP5.*;
ControlP5 cp5;

int myColor = color(255);
int c1,c2;
float n,n1;

int startX;
int startY;
int plusX;
int plusY;

int widthOfBtn;
int heightOfBtn;


fileInputForm[] forms = new fileInputForm[5];

String[] filepaths = new String[5];

textFile[] files = new textFile[5];

int num = 5; //총 다섯개의 인풋 파일을 만들 것임!

static int i=0;

PrintWriter output;


String resultText = "";

String[][] dividedString = new String[5][];

boolean fileSelectionStatus = false;

void setup()
{
  size(600,600);
  //for(int i=0; i<num; i++)
  //{
  //  forms[i] = new fileInputForm();
  //  files[i] = new textFile();
  //}
  setupGUI();
  //output = createWriter("text.txt");
}

void draw()
{
  drawGUI();
    //int offsetX = 10;
    //int offsetY = 10;
    //forms[0] = new fileInputForm(offsetX,offsetY,130,30,"form1");
    //forms[0].setBackgroundColor(125,126,30);
    
    //offsetY += 50;
    
    //forms[1] = new fileInputForm(offsetX,offsetY,130,30,"form2");
    //forms[1].setBackgroundColor(125,126,126);
    //offsetY += 50;
    
    //forms[2] = new fileInputForm(offsetX,offsetY,130,30,"form3");
    //forms[2].setBackgroundColor(125,126,126);
    //offsetY += 50;
    
    //forms[3] = new fileInputForm(offsetX,offsetY,130,30,"form4");
    //forms[3].setBackgroundColor(125,126,126);
    //offsetY += 50;
    
    //forms[4] = new fileInputForm(offsetX,offsetY,130,30,"form5");
    //forms[4].setBackgroundColor(125,126,126);
    
    //for(int i=0; i<num; i++)
    //{
    //  forms[i].update();
    //  forms[i].draw();
    //}
    //if(fileSelectionStatus==true)
    //{
    //   mergeTextFiles();
    //}
}

void mouseClicked()
{
  selectInput("Select a file to process:", "fileSelected");
}
 
void fileSelected(File selection) 
{
   if(selection!=null) 
   {
      filepaths[i] = selection.getAbsolutePath();
      files[i].loadText(filepaths[i]);
      files[i].printLoadText(filepaths[i]);
      println(i);
      if(i==4) fileSelectionStatus=true;
       i++;
   }
}
//텍스트를 합치기 위해서는 . 기준으로 텍스트를 한 문장씩 구분지어야 한다 
void mergeTextFiles()
{
  for(int i=0; i<num; i++)
  {
    loadTextByString(files[i].getLoadedText(),i);
  }
}

int loadTextByString(String content, int index)
{
  dividedString[index] = split(content,'.');
  print(dividedString[index]);
  output.println(dividedString[index]);
  return 1;
}
void keypressed()
{
   output.flush(); // Writes the remaining data to the file
   output.close(); // Finishes the file
   exit(); // Stops the program
}