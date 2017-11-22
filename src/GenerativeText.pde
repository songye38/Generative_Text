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
  
  //한 문장의 길이를 알기 위해서는 한 문장의 몇개의 char가 들어 있는지 알아야 한다 
  //생성된 한 문장의 단어들 각각의 너비를 총 더한 값을 함수로 만들어서 리턴해주기 
  
  //이 부분부터는 메인 함수에서 만들어야 될 것 같다 
  //한 문장의 전체 길이와 페이지의 너비를 비교해서 한 문장을 길게 늘여놓았을 때 그 길이가 페이지의 너비보다 길다면
  //특정 단어부터 잘라서 다음 줄로 이동시키기 
  //이때 제일 마지막 문장까지의 전체 높이를 구해서
  //다음 문장의 시작 y값으로 해주기 
  //이렇게 해서 한 페이지의 전체 높이만큼의 y가 차게 되면 다음 페이지에 있던 내용들을 지워주고 새로 그려주기 
  
  
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