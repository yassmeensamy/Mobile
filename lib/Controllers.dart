import 'package:flutter/material.dart';

String? validateMadatory(String? text) 
{
  if (text == null || text.isEmpty) {
    return 'This field is required';
  } 
}
String? validateEmail(String? email) {
  if (email == null || email.trim().isEmpty) 
  {
    return "This field is mandatory";
  } 
  else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email))
   {
    return 'Invalid email format';
   }
}


String? validatepassword(String? pass) 
{
  if (pass == null || pass.isEmpty) 
  {
      return "This field is mandatory";
  }
  else if (pass.length<8)
  {
     return 'At least 8 characters';
  } 
 
}
String? validateConpassword(String? pass,String? confirmpass) 

{
  if (confirmpass == null || confirmpass.isEmpty) 
  {
      return "This field is mandatory";
  }
  else if (confirmpass.length<8)
  {
     return 'At least 8 characters';
  } 
  
  else if(confirmpass!=pass)
  {
        return "Passwords do not match";
  }

}
