

//하나의 텍스트를 기준으로 만들기 
void setup()
{
  size(600,600);
  background(0);
  loadTextByString(loadText("art.txt"));
}

void draw()
{
  
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
 
int getTextLength(String filename) 
{
  int totalNumOfChar = loadText(filename).length();
  return totalNumOfChar;
}

void loadTextByString(String content)
{
  String[] dividedString = split(content,'.');
  
  //for test
  for(int i=0; i<dividedString.length; i++)
  {
    //println(dividedString[i]);
    int randomX = (int)random(-width/2,width);
    int randomY = (int)random(-height/2,height);
    GenerativeString string1 = new GenerativeString(dividedString[i],randomX, randomY, width, height);
    string1.drawString();
  }
}

void loadTextByWord(String[] content)
{
  
}

void loadTextByChar(String[] content)
{
  int totalNumOfChar = getTextLength("art.txt");
  char[] charSet = new char[totalNumOfChar];
  int sizeOfContent = content.length;
  print(sizeOfContent);
  for(int i=0; i<sizeOfContent; i++)
  {
    divide_to_char(content[i]); //한 단락의 전체 내용을 가지고 그것을 쪼개서 한 단어씩 분할 
  }
  //일단 여기서 각각의 문자들을 한번 초기화를 해보자 그리고 나중에 빼던지 해보자
  
}


//텍스트를 가져와서 단락별로 있는 내용들을 한 문장 단위로 쪼개기
//한 단어별로 쪼개기
//한 글자 단위로 쪼개기 