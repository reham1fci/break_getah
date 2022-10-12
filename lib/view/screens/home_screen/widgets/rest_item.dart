import 'package:break_getah/model/rest.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class   RestItem  extends StatelessWidget{
  Rest item ;
  int index ;
  Function? onTap ;


  RestItem({ required this.item,  required this.index ,this.onTap});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return   Padding(padding: EdgeInsets.all(10.0)  ,

      child:
      GestureDetector(
      onTap:()=> onTap!() ,


    child:
    Container(
      padding: EdgeInsets.all(5),
      width: 150,
      child:Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              item.image!,
              width: 150,
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
          Text(item.name! ,
            textAlign: TextAlign.center,
            overflow: TextOverflow.visible,)
        ],),
      )));

  }

}