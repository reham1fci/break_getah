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
          borderRadius: BorderRadius.circular(28.0),
          border: Border.all(width: 1.0, color: const Color(0xffeeeeee)),
        ),
        child: Row(children: [
       TextButton(onPressed:  showCountry, child: Text( buttonNm, style: TextStyle(color: AppColors.white  ,
         fontFamily: 'A Jannat LT',
         fontSize: 12,),textAlign: TextAlign.center  ,)) ,
        Expanded(child: TextField(

          controller: widget.edTxtController,
            decoration: new InputDecoration(
                contentPadding: EdgeInsets.only(bottom: 5 ,top: 5 ,left: 16 ,right: 16),
                hintStyle: TextStyle(color: AppColors.white , fontSize: 12),
                hintText: widget.hint
            ),
          )),
        ],),
      ))

    ;  }
}