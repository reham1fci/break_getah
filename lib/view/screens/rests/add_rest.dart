
import 'dart:convert';
import 'dart:ui';

import 'package:break_getah/ApiConnection/Api.dart';
import 'package:break_getah/localization/language_constrants.dart';
import 'package:break_getah/model/User.dart';
import 'package:break_getah/model/rest.dart';
import 'package:break_getah/utill/app_color.dart';
import 'package:break_getah/utill/app_constant.dart';
import 'package:break_getah/utill/app_images.dart';
import 'package:break_getah/view/base/PassEditText.dart';
import 'package:break_getah/view/base/alert_dialog.dart';
import 'package:break_getah/view/base/custom_button.dart';
import 'package:break_getah/view/base/title_text.dart';
import 'package:break_getah/view/screens/rests/widgets/EditText.dart';
import 'package:break_getah/view/screens/rests/widgets/image_view.dart';
import 'package:break_getah/view/screens/rests/widgets/phone_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../PlacePicker/place_picker.dart';


class AddRest extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
  return _State();
  }

}
class _State extends State<AddRest> {
  TextEditingController phoneEd  =  TextEditingController()  ;
  TextEditingController restNameEd  =  TextEditingController()  ;
  String phoneCode = "+966" ;
  String? lat , lng ;
  String address = "" ;
  Api api = Api() ;
  User? user ;

  getUserData() async {
    SharedPreferences  shared = await SharedPreferences.getInstance();
    user = User.fromJsonShared(json.decode(shared.getString("user")!));

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData() ;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Dialog(
      backgroundColor: Colors.transparent,

child:
    Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),

        image: DecorationImage(
          image: AssetImage(  Images.ADDRESTBK ,),
          fit: BoxFit.cover,
        ),) ,
      child: ClipRRect( // make sure we apply clip it properly
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
          child: Container(

            padding: EdgeInsets.all(10),
            width: double.infinity,
              height: 550,
              alignment: Alignment.center,
              color: AppColors.lightGrey.withOpacity(0.1),
              child:SingleChildScrollView(
               child:Column(children: [
              Padding(padding: EdgeInsets.all(20),child: TextTitle(getTranslated("add_new_rest", context)??"")) ,
                ImageView(),
                EditText(hint: getTranslated("rest_name", context)??"", imageStr:Images.user, edTxtController: restNameEd , ),

                PhoneView(hint: getTranslated("phone", context)??"", edTxtController: phoneEd ,onCountryClick:(String code){
                  // print("signup" +phoneCode) ;
                  phoneCode = "+$code"  ;
                }, ),
                Center(child:TextButton.icon(onPressed: onDefineLocation ,icon:Image.asset(Images.location ,color: AppColors.white,) , label: Text(getTranslated("define_location", context)??"",style: TextStyle(color: AppColors.white ,fontSize: 12),)) ),
                Padding(padding: EdgeInsets.only(top: 30) ,child: CustomBtn(buttonNm: getTranslated("save", context)??"", onClick: onSave,  backBtn:AppColors.buttonBk2, txtColor: AppColors.white,),)

              ],)
          ),
        ),
      ),
    )
      ,) );
  }
  onSave(){
    String phone= phoneEd.text ;
    String name  = restNameEd.text ;
    if(validation(phone: phone ,name: name)){
      Rest rest = Rest(name: name , phone: phone , phoneCode:phoneCode  , lng: lng , lat: lat , address:address ) ;
      api.request(url: Constants.INSERTRESTING,
          map: rest.restToMap(user!.userId!) ,
          onSuccess: onRequestSuccess,
          onError: (error) {}
      );
    }

  }

  onRequestSuccess(var  jsonStr ) {
    var jsonObj = json.decode(jsonStr);
    String  msg  = jsonObj['msg']  ;
    CustomDialog.dialog(context: context, title: "", message:msg, isCancelBtn: false ,onOkClick: (){
      Navigator.of(context).pop();
    }) ;
  }
  bool validation ({String? name ,  String? phone , }  ) {
    if (name!.isEmpty || address.isEmpty || phone!.isEmpty ) {
      return false;
    }
    else {
      return true;
    }
  }
  onDefineLocation ()  {
    print("onlocation") ;
    Navigator.push( context,
        MaterialPageRoute(builder: (context) => PlacePicker())).then((value ){
      setState(() {
        lat =   value["lat"].toString()  ;
        lng =   value["lng"].toString()  ;
        address =   value["address"]  ;
        //   locationEd.text = address ;
        print(address) ;
        print(lat) ;
        print(lng) ;
      });
    } );

  }
}