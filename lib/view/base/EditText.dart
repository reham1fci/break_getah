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
  child:TextField(controller:  edTxtController,enabled: true,
          onTap:()=> onTap!(),

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
         /*   prefixIconConstraints:  BoxConstraints(
                minHeight: 24,
                minWidth: 24
            ),*/
              prefixIcon:  Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Image(
                  image: AssetImage(
                   imageStr!,
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