import 'package:break_getah/utill/app_color.dart';
import 'package:flutter/material.dart';

class HomeButtons extends StatelessWidget{
  String? text ;
  Function? onClick ;

  HomeButtons({ this.text, this.onClick});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
      Container(
          decoration: BoxDecoration(
            color: const Color(0x7aeeeeee),
            borderRadius: BorderRadius.circular(12.0),
          ),
      child:
      TextButton(
          onPressed: ()=> onClick!(),
          child:Text(text!,style: TextStyle(color: Colors.black ,fontSize: 10,
            fontWeight: FontWeight.w700,

          ),) ));


  }
}