import 'package:break_getah/utill/app_color.dart';
import 'package:flutter/material.dart';
class PassEditText extends StatelessWidget{
  TextEditingController edTxtController  ;
 Function? onTap ;
 String? preIcon ;
 String? hint ;
 String? sufIcon ;
 Color?color ;
  PassEditText({this.onTap ,required this.edTxtController ,this.hint  , this.preIcon,this.sufIcon ,this.color, Key? key}): super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return  Padding(padding: const EdgeInsets.only(bottom: 8.0 , left: 30.0  , right: 30.0 , top: 8.0) ,
  child:TextField(controller:  edTxtController,enabled: true,
          onTap:()=> onTap!(),

keyboardType:TextInputType.visiblePassword ,
          decoration: InputDecoration(

             // isDense: true,
              contentPadding: EdgeInsets.all(16),
              filled: true,
              fillColor: AppColors.lightGrey,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
              prefixIcon:  Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Image(
                  image: AssetImage(
                   preIcon!,
                  ),
                  height: 20,
                  width: 20,
                ),
              ) ,
              suffixIcon:  Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Image(
                  image: AssetImage(
                    sufIcon!,
                  ),
                  height: 20,
                  width: 20,
                ),
              ),
            hintText: hint ,
            hintStyle: TextStyle(color: AppColors.greyDark),
          )  ,
      ),)

    ;  }
}