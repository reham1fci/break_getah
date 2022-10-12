import 'package:flutter/material.dart';

class IconBtn extends StatelessWidget{
String? buttonIcon ;
String? text ;
Function? onClick ;

IconBtn({this.buttonIcon, this.text, this.onClick});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
return
  TextButton.icon(onPressed: ()=> onClick!(),
      icon:Image.asset(buttonIcon!),
      label:Text(text!,style: TextStyle(color: Colors.white ,
        fontWeight: FontWeight.w700,
  ),) );


  }
}