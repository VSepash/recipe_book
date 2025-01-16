import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TextWidget {

  static TextStyle BoldFeildTextStyle()
  {
    
    
    return TextStyle(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight:FontWeight.bold 
              );
  }

  static TextStyle LightFeildTextStyle()
  {
    return TextStyle(
      color:Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.w500
      );
  }
}