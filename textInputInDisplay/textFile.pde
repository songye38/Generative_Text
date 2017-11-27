class textFile
{
  String[] original_text;
  String result_text = "";
  String theme = "";
  
  //생성자를 통해서 생성할 때 기본적인 이 텍스트 파일의 성격을 적어주기 
  textFile(){}
  textFile(String subject)
  {
    theme = subject;
  }
  
void loadText(String filepath)
{ 
  original_text = loadStrings(filepath);
  for(int i=0; i<original_text.length; i++)
  {
   result_text += original_text[i]; 
  }
}
}