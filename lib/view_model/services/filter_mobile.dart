class MyMobile
{
  static lastten(String input)
  {
     String lasttenDigits = "";  
    if (input.length > 10) 
    {
        lasttenDigits = input.substring(input.length - 10);
    } 
    else
    {
        lasttenDigits = input;
    }
    return lasttenDigits;

  }
  

}