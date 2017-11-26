//한 문장씩 차례대로 출력되는 함수 만들기 
class GenerativeString 
{
  
  String mainString ="";
  int fontRedColor =0;
  int fontGreenColor =0;
  int fontBlueColor =0;
  int fontTransparency =0;
  
  int boundingBox_startX =0;
  int boungdingBox_startY =0;
  int boundingBox_endX =0;
  int boundingBox_endY =0;
  
  int posX =0;
  int posY =0;
  
  int fontSize =0;
  
  int totalLength =0;
  
  PFont font;
  
  
  //기본 생성자 정의 
  GenerativeString(String GenerativeString)
  {
    mainString = GenerativeString;
    font = createFont("Verdana",32);
    textFont(font);
    textSize(20);
  }
  
  //바운딩 박스까지 포함한 생성자 정의 
  GenerativeString(String GenerativeString,int startX, int startY, int endX, int endY)
  {
    mainString = GenerativeString;
    boundingBox_startX = startX;
    boungdingBox_startY = startY;
    boundingBox_endX = endX;
    boundingBox_endY = endY;
  }
   
  void setFontColor(int red, int green, int blue)
  {
    fontRedColor = red;
    fontGreenColor = green;
    fontBlueColor = blue;
  }
  void setTransparency(int amount)
  {
    fontTransparency = amount;
  }
  void setFontSize(int size)
  {
    fontSize = size;
  }
  void setFont(int index)  //set font by index 
  {
    String[] fontList = PFont.list();
    font = createFont(fontList[index],32);
    textFont(font);
  }
  void setPosX(int x)
  {
    posX =x;
  }
  void setPosY(int y)
  {
    posY = y;
  }
  void setBoundingBox(int startX, int startY, int endX, int endY)
  {
    boundingBox_startX = startX;
    boungdingBox_startY =startY;
    boundingBox_endX =endX;
    boundingBox_endY =endY;
  }
  //하나의 문자를 찍는 함수 특정 위치에 
  void drawString()
  {
      text(mainString,boundingBox_startX,boungdingBox_startY,boundingBox_endX,boundingBox_endY);    
  } 
  void drawString(int startX, int startY, int endX, int endY)
  {
     text(mainString,startX,startY,endX,endY);    
  } 
  //int startOffset()
  //{
  //  int x;
  //  x = 
  //  return x;
  //}
  //void drawStringByLine(int screenWidth, int screenHeight)  //전체 화면의 너비와 높이를 매개변수로 주기
  //{
  //  //한 문장의 단어의 개수는 몇개일까?
  //  //그 단어의 개수 x 한 글자의 너비 -> 전체 문장의 너비구해주기 
  //  int length = getLengthOfString();
  //  int totalLength =0;
  //     for(int i=0; i<getNumOfCharsInString(); i++)
  //     {
  //       char eachChar = mainString.charAt(i);
  //       totalLength += textWidth(eachChar);
  //       if(totalLength>width){
           
  //       }
  //     }
      
  //  //한 문장의 오프셋을 반환하는 함수 만들기 -> 다음 문장은 이 오프셋 값을 받아서 이 오프셋 다음 위치에 찍어주기
  //}

  
  //단어의 개수가 아닌 폰트의 너비를 포함한 실질적인 문장의 길이(시각적 길이)
  int getLengthOfString()
  {
    int num = getNumOfCharsInString();
    char[] charArray = new char[num];
    
    int totalLength =0;
    for(int i=0; i<num; i++)
    {
      totalLength = (int)textWidth(charArray[i]);
    }
    
    return totalLength;
  }
  int getNumOfCharsInString()
  {
    int num = mainString.length();
    return num;
  }
  
  //한 문장의 길이를 알기 위해서는 한 문장의 몇개의 char가 들어 있는지 알아야 한다 
  //생성된 한 문장의 단어들 각각의 너비를 총 더한 값을 함수로 만들어서 리턴해주기 
  
  //이 부분부터는 메인 함수에서 만들어야 될 것 같다 
  //한 문장의 전체 길이와 페이지의 너비를 비교해서 한 문장을 길게 늘여놓았을 때 그 길이가 페이지의 너비보다 길다면
  //특정 단어부터 잘라서 다음 줄로 이동시키기 
  //이때 제일 마지막 문장까지의 전체 높이를 구해서
  //다음 문장의 시작 y값으로 해주기 
  //이렇게 해서 한 페이지의 전체 높이만큼의 y가 차게 되면 다음 페이지에 있던 내용들을 지워주고 새로 그려주기   
}

//문장을 순서대로 차례차례 출력하는 것을 어떻게 만들면 좋을까?
//text단위로 출력되는게 맞을까 아니면 char단위로 출력되고 끝을 만나면 다음 문장으로 넘어가게 하는게 맞을까?

/* 2017.11.25 text에서는 한 페이지에 하나씩 출력되도록 해보기 -> 이렇게 해서 문장을 구성해보면 어떨까?
*/