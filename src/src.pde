

//전역변수들 
Table humanity;
Table art;
Table tech;
PFont font;
Table originalText;

String humanityText[];
String artText[];
String techText[];

//이렇게 각각 분야별로 텍스트를 나누는 건 개발을 할 때 별로 좋은 건 아닌 것 같다 
//그냥 type으로 텍스트의 분야를 나누고 모든 텍스트를 하나의 파일에 담는게 좋은 것 같다 

String resultString[];
  int x = width;


//내가 해야할 것은 무엇인가?
//각 csv파일의 총 열을 구하기(길이 구하기)
//그 길이를 바탕으로 (seed) random value구하기
//위에서 구한 random value를 기반으로 이 값에 해당하는 row의 text를 가져와서 
//총 세개의 텍스트를 하나의 텍스트로 만들어주기 

void setup()
{
  size(600,600);
  background(0);
  humanity = loadTable("humanity.csv", "header");
  art = loadTable("art.csv", "header");
  tech = loadTable("technology.csv", "header");
  originalText = loadTable("data.csv","header");
}

void draw()
{
  
}



//nLines -> number of Lines you want to display
void printFuzzyText(int nLines)
{
  
  
int lengthOfHuman = humanity.getRowCount();
int lengthOfArt = art.getRowCount();
int lengthOfTech = tech.getRowCount();


  
  for(int i=0; i<nLines; i++)
  {
    int humanRandomValue = int(random(lengthOfHuman));
    int artRandomValue = int(random(lengthOfArt));
    int techRandomValue = int(random(lengthOfTech));
    
    //merge all three string into resultString
    //and then print it to displays 
    resultString[0] = humanity.getString(humanRandomValue,"text");
    resultString[1] = tech.getString(techRandomValue,"text");
    resultString[2] = art.getString(artRandomValue,"text");
    
    int lengthOfText = (humanity.getString(humanRandomValue,"text")).length();
    
    
    //randomTextSize = int(random(10,15));
    //textSize(randomTextSize);
    
    //text_align(2);
    //draw_underLine(lengthOfText);
    //text(resultString,30,10,550,550);
    
    //print to console 
    //print(humanity.getString(humanRandomValue,"text"));
    //print(tech.getString(techRandomValue,"text"));
    //println(art.getString(artRandomValue,"text"));
  } 
}

//여기서의 n은 내가 바꾸고 싶은 정도 
//즉 n이 커질수록 텍스트의 정렬도가 낮아진다 
void text_align(int n)
{
  //내가 선택한 값만큼의 랜덤 크기를 가지고 이걸 바탕으로 텍스트를 정렬하면 좋을텐데...
  int textAlignRandomValue = int(random(-n,n));
}
//이런식으로 하면 대각선의 빨간선이 생기는데 
//우선은 이걸 좀 여러개 만들어 보자 -> 랜덤하게
//그리고 텍스트가 동적으로 생성되는 동안 이 빨간선도 생성되게 만들어보자 
//그냥 그려지는 것이 아니라 생성되도록 만들어보자 
//입력값으로 한 문장의 길이를 입력받아서 그걸 바탕으로 라인을 그려보면 어떨까?

void draw_underLine()
{
  stroke(255);
  line(0,0,width/2,height/2);
}
void draw_underLine(int length)
{
  int startPointWidth = int(random(0,length));
  int startPointHeight = int(random(0,length));
  int randomValueWidth = int(random(-length,0));
  int randomValueHeight = int(random(0,length));
  stroke(255,0,0);
  line(startPointWidth,startPointHeight,randomValueWidth,randomValueHeight);
}

//함수를 이용해서 텍스트를 좀 더 다양하게 표현해보자
//1. 밑줄을 단어 중간 중간에 넣어보자 
//2. 단어의 색깔을 바꿔보면 어떨까?
//3. 마우스 인풋에 따라 시작점을 바꿔주는 텍스트는 어떨까?
//이렇게 바꾼 기능들을 화면안에 있는 gui로 바꾸도록 만들어주기 
//

//pdf로 저장하기 


//글자를 draw()안에서 한 글자씩 출력해보기 
void printByChar()
{
  int index =0;
  int lengthOfResultString = resultString.length;
  for(int i=0; i<lengthOfResultString; i++)
  {
  
    textAlign(LEFT);
    textSize(16);
    text(resultString[index],x,100);
    
    // Decrement x
    x = x - 3;

  // If x is less than the negative width, 
  // then it is off the screen
  float w = textWidth(resultString[index]);
  if (x < -w) {
    x = width; 
    index = (index + 1) % resultString.length;
  }
  } 
}

//csv파일에 있는 텍스트들을 가져와서 String[]에 담아두기 
void init_text(Table data)
{
  int lenOfTableRow = getTableRowCount(data);
  for(int i=0; i<lenOfTableRow; i++)
  {
    int index = data.getInt(i,"type");
    if(index==1)
    {
      artText[i] = data.getString(i,"text");
    }
    else if(index==2)
    {
      humanityText[i] = data.getString(i,"text");
    }
    else if(index==3)
    {
      techText[i] = data.getString(i,"text");
    }
  } 
}

void init_font()
{
  font = createFont("Verdana",10);
  textFont(font);
}

void getStringLength()
{
  
}

//테이블의 열의 개수를 반환하는 함수 
int getTableRowCount(Table table)
{
  int length = table.getRowCount();
  return length;
}