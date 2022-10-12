import 'package:break_getah/utill/app_color.dart';
import 'package:flutter/material.dart';
class EditText extends StatelessWidget{
  TextEditingController edTxtController  ;
 Function? onTap ;
 String? imageStr ;
  String? hint  ;

  Color?color ;
  EditText({this.onTap ,required this.edTxtController ,this.imageStr,this.color,this.hint, Key? key}): super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return  Padding(padding: const EdgeInsets.only(bottom: 8.0 , left: 30.0  , right: 30.0 , top: 8.0) ,
  child:TextField(
    textAlign: TextAlign.center,

    controller:
  edTxtController,enabled: true,
          onTap:()=> onTap!(),

          decoration: InputDecoration(
             // isDense: true,
              contentPadding: EdgeInsets.only(bottom: 5 ,top: 5 ,left: 16 ,right: 16),
              filled: true,
              fillColor: Colors.transparent,
            enabledBorder:  OutlineInputBorder(
              borderRadius: BorderRadius.circular(26),
              borderSide: const BorderSide(color: Colors.white, width: 1.0),

            ),

         /*   prefixIconConstraints:  BoxConstraints(
                minHeight: 24,
                minWidth: 24
            ),*/

            hintText: hint ,

            hintStyle: TextStyle(color: AppColors.white ,fontSize: 12),
          )  ,

      ),)

    ;  }
}