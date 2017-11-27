
fileInputForm[] forms = new fileInputForm[5];

String[] filepaths = new String[5];

textFile[] files = new textFile[5];

int num = 5; //총 다섯개의 인풋 파일을 만들 것임!



void setup()
{
  size(600,600);
  for(int i=0; i<num; i++)
  {
    forms[i] = new fileInputForm();
    files[i] = new textFile();
  }
}

void draw()
{
    int offsetX = 10;
    int offsetY = 10;
    forms[0] = new fileInputForm(offsetX,offsetY,130,30,"form1");
    forms[0].setBackgroundColor(125,126,30);
    
    offsetY += 50;
    
    forms[1] = new fileInputForm(offsetX,offsetY,130,30,"form2");
    forms[1].setBackgroundColor(125,126,126);
    offsetY += 50;
    
    forms[2] = new fileInputForm(offsetX,offsetY,130,30,"form3");
    forms[2].setBackgroundColor(125,126,126);
    offsetY += 50;
    
    forms[3] = new fileInputForm(offsetX,offsetY,130,30,"form4");
    forms[3].setBackgroundColor(125,126,126);
    offsetY += 50;
    
    forms[4] = new fileInputForm(offsetX,offsetY,130,30,"form5");
    forms[4].setBackgroundColor(125,126,126);
    
    for(int i=0; i<num; i++)
    {
      forms[i].update();
      forms[i].draw();
    }
}

void mouseClicked()
{
  selectInput("Select a file to process:", "fileSelected");
}


//차례차례 텍스트들을 입력한 다음에 각각의 성격의 텍스트들을 입력받아 다양한 텍스트 만들기 
void fileSelected(File selection) 
{
   if(selection!=null) 
   {
      filepaths[0] = selection.getAbsolutePath();
      files[0].loadText(filepaths[0]);
   }
}


//각각을 생성자를 통해서 생성하고 