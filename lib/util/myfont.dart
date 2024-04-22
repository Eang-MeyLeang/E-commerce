

import 'package:flutter/material.dart';

class MyFont{
    static double? titleSize = 17;
    static double? titlecontent = 20;

    
    static TextStyle textTitleStyle = TextStyle(fontSize: MyFont.titleSize, fontFamily: 'Roboto-Medium',fontWeight: FontWeight.w500,color: Colors.black);
    static TextStyle textLabelStyle = TextStyle( fontSize: MyFont.titleSize, fontFamily: 'Roboto-Mediume',fontWeight: FontWeight.normal,color: Colors.black);
    static TextStyle TextContentStyle = TextStyle( fontSize: MyFont.titlecontent, fontFamily: 'Roboto-Medium',fontWeight: FontWeight.w600,color: Colors.black);

}