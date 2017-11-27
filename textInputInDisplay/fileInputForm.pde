class fileInputForm
{
  int startX, startY;
  int formWidth,formHeight;
  String text = "";
  PFont font;
  int fontSize = 0;
  color fontColor;
  color backgroundColor;
  color hoverColor;
  boolean rectOver = false;
  //boolean mouseStatus = false;
  
  
  //------------------ 생성자-----------------------//
  fileInputForm()
  {
    font = createFont("Verdana",32);
    textFont(font);
    setFontSize(20);
  }
  fileInputForm(int beginX, int beginY, int rectWidth, int rectHeight)
  {
    this.startX = beginX;
    this.startY = beginY;
    this.formWidth = rectWidth;
    this.formHeight = rectHeight;
  }
  fileInputForm(int beginX, int beginY, int rectWidth, int rectHeight, String content)
  {
    this.startX = beginX;
    this.startY = beginY;
     this.formWidth = rectWidth;
    this.formHeight = rectHeight;
    text = content;
  }
  
  //--------------------- set method----------------------//
  void setFontColor(color rgb)
  {
    fontColor = color(rgb);
  }
  void setFontSize(int size)
  {
    fontSize = size;
  }
  void setBackgroundColor(int r, int g, int b)
  {
    backgroundColor = color(r,g,b);
  }
  void setHoverColor(int r, int g, int b)
  {
    hoverColor = color(r,g,b);
  }
  
  //-------------------get method----------------------//
  int getHoverStatus()
  {
    if(rectOver)
    {
      return 1;
    }
    else
    {
      return 0;
    }
  }
  //생성자를 통해서 정의한 사각형을 그리기 
  void draw()
  {
    fill(backgroundColor);
    if(rectOver)
    {
      fill(0,0,0);
    }
    noStroke();
    rect(startX, startY, formWidth, formHeight);
  }
  
  void update()
  {
    //마우스가 사각형 안쪽에 와 있다면 호버컬러를 바꿔주기 지속적으로 
    if(overRect())
    {
      rectOver = true;
    }
  }
  
  boolean overRect()
  {
    if(mouseY>=startY && mouseY<=startY+formHeight)
    {
      return true;
    }else{
      return false;
    }
  }
}