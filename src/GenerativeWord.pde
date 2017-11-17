

//한 단어 -> 안녕 / 사랑 / 바보 
//단어 + 어미 -> 사랑해 

// 필요한 변수들
// 그러니까 이 클래스를 가지고 생성을 하면 하나의 단어를 생성할 수 있다 
// 한 단어의 높이와 너비  -> 이건 내가 비트맵으로 글자를 만들어봐야 알 수 있지 않을까?
// 단어의 위치값 
//단어의  색상 값
//단어의 폰트는 어떤걸로?// 필요한 변수들

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

  //하나의 문자를 찍는 함수 특정 위치에 
  void drawString()
  {
      text(word,posX,posY);    
  } 
}