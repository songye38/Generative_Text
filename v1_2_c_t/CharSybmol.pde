//하다 보니까 generativeChar 클래스와 완전히 똑같다 
//굳이 새로운 클래스를 만들 필요가 없을 것 같은데?



class CharSymbol extends GenerativeChar
{
  int index;
  
  CharSymbol(char initChar)
  {
    super(initChar);
  }
  CharSymbol(char initChar, int x, int y)
  {
    super(initChar, x,y);
  }
  
  //특정 위치에 문장을 만들면서 찍어주는게 쉽지는 않을 것 같다 
  void drawSymbos()
  {
    drawChar();
  }
  int initSymbolIndex(int length)
  {
    int index = 0;
    index = (int)random(length);
    return index;
  }
  void setIndex(int n)
  {
    index = n;
  }
  void printIndex()
  {
    println(index);
  }
  int getIndex()
  {
    return index;
  }
  
}