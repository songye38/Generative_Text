
Table humanity;
Table art;
Table tech;
PFont font;

//내가 해야할 것은 무엇인가?
//각 csv파일의 총 열을 구하기(길이 구하기)
//그 길이를 바탕으로 (seed) random value구하기
//위에서 구한 random value를 기반으로 이 값에 해당하는 row의 text를 가져와서 
//총 세개의 텍스트를 하나의 텍스트로 만들어주기 

void setup()
{
  size(600,600);
  background(0);
  font = createFont("Verdana",10);
  textFont(font);
  humanity = loadTable("humanity.csv", "header");
  art = loadTable("art.csv", "header");
  tech = loadTable("technology.csv", "header");
  printFuzzyText(3); 
}

void draw()
{
   
}

void printFuzzyText(int nTimes)
{
  String resultString = "";
  int lengthOfHuman = humanity.getRowCount();
  int lengthOfArt = art.getRowCount();
  int lengthOfTech = tech.getRowCount();
  
  int randomTextSize =0;
 
  
  for(int i=0; i<nTimes; i++)
  {
    int humanRandomValue = int(random(lengthOfHuman));
    int artRandomValue = int(random(lengthOfArt));
    int techRandomValue = int(random(lengthOfTech));
    
    //merge all three string into resultString
    //and then print it to displays 
    resultString += humanity.getString(humanRandomValue,"text");
    resultString += tech.getString(techRandomValue,"text");
    resultString += art.getString(artRandomValue,"text");
    
    //randomTextSize = int(random(10,15));
    //textSize(randomTextSize);
    
    text(resultString,30,10,550,550);
    
    //print to console 
    //print(humanity.getString(humanRandomValue,"text"));
    //print(tech.getString(techRandomValue,"text"));
    //println(art.getString(artRandomValue,"text"));
  } 
}

//함수를 이용해서 텍스트를 좀 더 다양하게 표현해보자
//1. 밑줄을 단어 중간 중간에 넣어보자 
//2. 단어의 색깔을 바꿔보면 어떨까?
//3. 마우스 인풋에 따라 시작점을 바꿔주는 텍스트는 어떨까?
//이렇게 바꾼 기능들을 화면안에 있는 gui로 바꾸도록 만들어주기 

//pdf로 저장하기 