import 'package:flutter/material.dart';

class TextTitle extends StatelessWidget{
String? title  ;

TextTitle(this.title);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
      Container(
        width: double.infinity,
       padding: EdgeInsets.only(top: 10 ,bottom: 10 ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28.0),
          border: Border.all(width: 1.0, color: const Color(0xffeeeeee)),
        ),
        child: Text(title! ,textAlign: TextAlign.center,  style: TextStyle(
          fontFamily: 'A Jannat LT',
          fontSize: 18,
          color: const Color(0xffeeeeee),
          letterSpacing: -0.005400000214576721,
          fontWeight: FontWeight.w700,
        ),),
      ) ;
  }
}