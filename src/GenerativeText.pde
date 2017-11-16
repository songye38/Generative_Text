

// 필요한 변수들
// 그러니까 이 클래스를 가지고 생성을 하면 하나의 단어를 생성할 수 있다 
// 한 단어의 높이와 너비  -> 이건 내가 비트맵으로 글자를 만들어봐야 알 수 있지 않을까?
// 단어의 위치값 
//단어의  색상 값
//단어의 폰트는 어떤걸로?// 필요한 변수들

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
  
  PFont font;
  
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
}


//void draw()
//{
//  String s = "Lorem ipsum dolor sit amet, enim placerat consectetuer et sociosqu fusce luctus. Mauris rerum auctor, eget aliquam, ultrices orci sed id orci etiam in. Justo vitae pede arcu tristique libero, hac ultricies, scelerisque elit sed ac eu suspendisse aliquam. Luctus urna, egestas lorem justo. Natoque ante in sit. Sodales scelerisque est scelerisque, congue pellentesque, tellus est quis ipsum arcu, est proin. Morbi augue ut sit vitae feugiat, velit risus, eget montes nec vestibulum tempus elit habitant. Justo turpis et hymenaeos, senectus ipsum elit ac.Ipsum mauris sit volutpat ante ipsum turpis, et nec. Sit odio. Quo dolor elementum non sit, odio ac feugiat sit dolor sit commodo, nulla consequat pede velit aliquam ipsum. Elit euismod at erat euismod, non risus, nullam sit aenean vel et ipsum tellus, velit morbi accumsan volutpat mi luctus. A ultrices. Adipiscing aliquam blandit in, in justo, tincidunt auctor praesent mattis quam, amet nulla ullamcorper sit massa. Saepe neque massa elit curabitur lectus. Placerat est vestibulum vestibulum, fames purus, pede elit nam aenean sit tortor, aliquet urna cras purus dis fermentum, neque metus eu.Vehicula nonummy, elit dictum augue nulla diam, quam vulputate cras nibh non, in sed adipiscing quam, porttitor at eget. Dignissim vestibulum donec malesuada cubilia, gravida interdum donec amet sit tempus felis, nunc mauris. Mollis duis lectus et eros pede mauris, amet feugiat auctor eget curabitur dui sed, mattis magna in dui lobortis. Sit lacus consequat ut, tortor eleifend justo vitae nibh pellentesque, mauris dolorem sodales mauris integer et. Sit suspendisse wisi dolor, vestibulum semper ut sed sit non mauris, ad dui felis odio mattis eget, in magna augue sed. Curabitur ultrices magna mi nisl vitae torquent, nisl elit a tempus lectus accumsan, vitae felis velit libero suspendisse cras.At nunc mauris aliquam. Massa sed lorem suspendisse urna, ut aliquam, ut luctus pede libero ipsum mollis ante. In ut sapien. Lorem id, ornare ut magna quis ornare. Massa quasi tellus gravida ut nam, duis libero, porttitor tellus.";
//  int startX = (int)random(0,900);
//  int startY = (int)random(0,900);
//  int endX = (int)random(startX,900);
//  int endY = (int)random(startY,900);
//  setRandomFontSize();
//  setRandomFont();
//  setRandomTextColor();
//  text(s, startX,startY, endX,endY);  // Text wraps within text box
//}