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
}