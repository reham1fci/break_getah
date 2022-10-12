import 'package:break_getah/utill/app_color.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
class PhoneView extends StatefulWidget{
  TextEditingController edTxtController  ;
  Function? onTap ;
  Function? onCountryClick ;
  String? hint  ;
  PhoneView({this.onTap ,required this.edTxtController ,this.hint,this.onCountryClick , Key? key}): super(key: key);

  @override
  State<PhoneView> createState() => _PhoneViewState();
}

class _PhoneViewState extends State<PhoneView> {
String buttonNm="SA +966" ;
  showCountry(){
    showCountryPicker(
      context: context,
      showPhoneCode: true, // optional. Shows phone code before the country name.
      onSelect: (Country country) {
        print('Select country: ${country.displayName}');
        print('Select country: ${country.countryCode}');
        print('Select country: ${country.name}');
        print('Select country: ${country.phoneCode}');
        setState(() {
          buttonNm = "${country.countryCode}  + ${country.phoneCode}" ;
         widget.onCountryClick!(country.phoneCode);
        });
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return  Padding(padding: const EdgeInsets.only(bottom: 8.0 , left: 30.0  , right: 30.0 , top: 8.0) ,
      child:Container(
      //  color: AppColors.lightGrey,
        decoration: BoxDecoration(
          color: AppColors.lightGrey,
          borderRadius: BorderRadius.circular(40.0),
        ),
        child: Row(children: [
       TextButton(onPressed:  showCountry, child: Text( buttonNm, style: TextStyle(color: AppColors.black  ,
         fontFamily: 'A Jannat LT',
         fontSize: 16,),textAlign: TextAlign.center  ,)) ,
        Expanded(child: TextField(
          controller: widget.edTxtController,
            decoration: new InputDecoration.collapsed(
                hintText: widget.hint
            ),
          )),
        ],),
      ))

    ;  }
}