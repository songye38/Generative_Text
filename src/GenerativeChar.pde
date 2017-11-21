
// 필요한 변수들
// 한 글자의 unicode 값
// 한 글자의 높이와 너비  -> 이건 내가 비트맵으로 글자를 만들어봐야 알 수 있지 않을까?
// 글자의 위치값 
//글자의 색상 값
//글자의 폰트는 어떤걸로?


class GenerativeChar
{
  char mainChar =0;
  int fontRedColor =0;
  int fontGreenColor =0;
  int fontBlueColor =0;
  int fontTransparency =0;
  
  int posX =0;
  int posY =0;
  
  int charWidth =0;
  int charHeight =0;
  
  int charLength =0;
  
  int fontSize =0;
  
  PFont font;
  
  GenerativeChar(char GenerativeChar)
  {
    mainChar = GenerativeChar;
  }
  
  GenerativeChar(char GenerativeChar, int x, int y)
  {
    mainChar = GenerativeChar;
    posX = x;
    posY = y;
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
  //하나의 문자를 찍는 함수 특정 위치에 가장 기본적인 함수
  void drawChar()
  {
      text(mainChar,posX,posY);    
  } 
  void drawChar(int pageWidth, int pageHeight)
  {
    
  }
}