
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
void divide_to_char(String textOriginal)
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
  for(int i=0; i<stringLength; i++)
  {
    print(oneChar[i]);
  }
}


//이런식으로 텍스트를 가져오면 거의 문단 단락별로 텍스트가 들어오는구나 
String[] loadText(String filename)
{
  String[] content = loadStrings(filename);
  return content;
  //ex) String[0] -> 첫번째 단락
  //ex) String[1] -> 두번째 단락 
}
void loadTextByString(String[] content)
{
  int sizeOfContent = content.length;
 // String[] stringContent = new String[sizeOfContent];
  for(int i=0; i<sizeOfContent; i++)
  {
    divide_to_char(content[i]);
  }
  
  //print(sizeOfContent);
}

void loadTextByWord(String[] content)
{
  
}

void loadTextByChar(String[] content)
{
  int sizeOfContent = content.length;
  for(int i=0; i<sizeOfContent; i++)
  {
    divide_to_char(content[i]);
  }
}


//텍스트를 가져와서 단락별로 있는 내용들을 한 문장 단위로 쪼개기
//한 단어별로 쪼개기
//한 글자 단위로 쪼개기 