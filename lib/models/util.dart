// here we are going to write all needed logcs 
// for example sorting items ....


/*
- 50% of every cash on hand goes to hidden till the end of the month 
- every item price is calculated based on the left 40% and will be listed from high to low priority
- 10% for pocket (personal use)
*/

class Utils{

  static String? validateInput(String? value){
    if(value!.isEmpty || value == "")return "Input Value Required";
    return null;
  }
}