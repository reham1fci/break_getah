import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget{
   String buttonNm ;
    Function onClick ;
    Color backBtn  ;
    Color txtColor  ;
   CustomBtn({required this.buttonNm  , required this.backBtn ,required this.txtColor , Key? key,  required this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
      Center(child:Container(
    decoration:  BoxDecoration(
    color:backBtn,
    borderRadius: const BorderRadius.all(
     Radius.circular(40),
    )),
  //  width: double.infinity,
    child:
    Padding(
        padding:
        const EdgeInsets.only( left: 60.0, right: 60.0, ),
    child:  TextButton(
      onPressed:()=> onClick(),

      child:
        // child:
           Text(
            buttonNm,
            style:   TextStyle(color:txtColor ,fontWeight: FontWeight.bold,fontSize:20 ),
            textAlign:  TextAlign.center,
          ) ,

    )))  );


  }
}