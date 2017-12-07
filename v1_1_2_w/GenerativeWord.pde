

//이 클래스를 이용해서 단어에 밑줄을 긋거나 단어를 다른 단어로 바꾸거나 하는 것들이 필요하다 
class GenerativeWord 
{
  String word ="";
  
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
  
  PFont font;
  
  GenerativeWord(String GenerativeWord)
  {
    word = GenerativeWord;
  }
  
  GenerativeWord(String GenerativeWord,int x, int y)
  {
    word = GenerativeWord;
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
  String getWord()
  {
    return word;
  }

  //하나의 문자를 찍는 함수 특정 위치에 
  void drawWord()
  {
      text(word,posX,posY);    
  } 
  void drawWord(int x,int y)
  {
    text(word,x,y);
  }
}