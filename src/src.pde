

//글자와 단어 그리고 문장을 담을 배열들 
GenerativeChar[] charArray;
GenerativeWord[] wordArray;
GenerativeString[] textArray;


//처음의 텍스트에서 각각의 단위로 자른 내용을 넣을 변수 
String[] dividedString;
String[] dividedWord;
char[] dividedChar;

int i=0;


//하나의 텍스트를 기준으로 만들기 
void setup()
{
  size(600,600);
  background(0);
  loadTextByString(loadText("art.txt"));
  loadTextByWord(loadText("art.txt"));
  loadTextByChar(loadText("art.txt"));
  
  initGenerativeString(dividedString);
  initGenerativeWord(dividedWord);
  initGenerativeChar(dividedChar);
  
  frameRate(1);
  
}

void draw()
{
  
  setStringBoundingBox(dividedString);
  drawString(i);
  i++;
}

//하나의 전체 텍스트를 입력 받으면 그걸 한 문장 단위로 쪼개기 
char[] divide_to_char(String textOriginal)
{
  //근데 이걸 한 문장 단위로 쪼갤 수가 있나?
  int stringLength = textOriginal.length();
  
  char[] oneChar = new char[stringLength];
  
  for(int i=0; i<stringLength; i++)
  {
    if(textOriginal.charAt(i)!='.')
    {
      oneChar[i] = textOriginal.charAt(i);
    }
    else
    {
      oneChar[i] = '\n';
    }
  }
  //for(int i=0; i<stringLength; i++)
  //{
  //  print(oneChar[i]);
  //}
  return oneChar;
}


//원래 loadStrings를 하면 엔터를 기준으로 단락별로 텍스트가 들어온다
//단락별로 텍스트가 들어오면 처리하기 까다롭다
//그냥 문단 구별 없이 하나의 텍스트를 입력받자
//최종 하나의 텍스트는 finalContent라 하자 
String loadText(String filename)
{
  String[] content = loadStrings(filename);
  String finalContent = content[0];
  return finalContent;
}
 
//int getTextLength(String filename) 
//{
//  int totalNumOfChar = loadText(filename).length();
//  return totalNumOfChar;
//}
//int getNumOfChar(String content)
//{
//  int length = content.length();
//  //int index=0;
//  //while(content.charAt(index)!='\n')
//  //{
//  //  length++;
//  //  index++;
//  //}
//  return length;
//}

//로드한다는 것은 진짜 텍스트를 가져만 온다는 뜻
//아직 클래스에 초기화를 한건 아니다 
int loadTextByString(String content)
{
  dividedString = split(content,'.');
  return 1;
}


//한 문장이 아니라 단어로 출력해주기 
int loadTextByWord(String content)
{
  dividedWord = split(content,' ');
  return 1;
}


//한 문자씩 출력하는 방법 
//한 단락의 길이는 1이다 
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

void setCharPos(int i)
{
    int randomX = int(random(10,width));
    int randomY = int(random(10,height));
    charArray[i].setPosX(randomX);
    charArray[i].setPosY(randomY);
}

/* 2017.11.22 
*
*/

//void drawStringWithinBox(String[] dividedString)
//{
//  int num = dividedString.length;
//  for(int i=0; i<num; i++)
//  {
//    int widthOfString = textArray[i].getNumOfCharsInString();
//    if(widthOfString>width)
//    {
//      textArray[i].
//    }
    
//  }
//}