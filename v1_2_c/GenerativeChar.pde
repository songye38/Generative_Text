
class GenerativeChar
{
  char mainChar =0;
  color fontColor;
  int fontTransparency =0;
  
  int posX =0;
  int posY =0;
  
  int charWidth =0;
  int fontSize =0;
 
  int charLength =0;
  
  PFont font;
  
  GenerativeChar(char GenerativeChar)
  {
    mainChar = GenerativeChar;
    font = createFont("NanumSquareOFTLight",32);
    textFont(font);
    textSize(20);
    setFontSize(20);
  }
  
  GenerativeChar(char GenerativeChar, int x, int y)
  {
    mainChar = GenerativeChar;
    posX = x;
    posY = y;
  }
   
  void setFontColor(color value)
  {
    fontColor = value;
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
  void setCharWidth()
  {
     charWidth = (int)textWidth(mainChar);
  }
  float getCharWidth()
  {
    float width = textWidth(mainChar);
    return width;
  }
  int getFontSize()
  {
    int size = fontSize;
    return size;
  }
  
  //하나의 문자를 찍는 함수 특정 위치에 가장 기본적인 함수
  void drawChar()
  {  
      fill(fontColor);
      textSize(fontSize);
      text(mainChar,posX,posY);    
  } 
  void drawChar(int x, int y)
  {
     fill(fontColor);
      textSize(fontSize);
    text(mainChar,x,y);
  }
   void drawChar(float x, int y)
  {
     fill(fontColor);
     textSize(fontSize);
     text(mainChar,x,y);
  }
  char getChar()
  {
    return mainChar;
  }
}