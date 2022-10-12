
import 'dart:convert';

import 'package:break_getah/model/User.dart';
import 'package:break_getah/utill/app_color.dart';
import 'package:break_getah/utill/app_constant.dart';
import 'package:break_getah/view/base/PassEditText.dart';
import 'package:break_getah/view/base/alert_dialog.dart';
import 'package:break_getah/view/base/custom_button.dart';
import 'package:break_getah/view/screens/home_screen/home_view.dart';
import 'package:break_getah/view/screens/login/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../ApiConnection/Api.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../utill/app_images.dart';
import '../../../base/EditText.dart';
import 'phone_view.dart';


class LoginBody extends StatefulWidget{
  const LoginBody({Key? key}) : super(key: key);

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
bool isLoading = false  ;
TextEditingController phoneEd  =  TextEditingController()  ;
TextEditingController passEd  =  TextEditingController()  ;
Api api  = Api() ;
bool rememberMe  = false ;
String phoneCode = "+966" ;
 late SharedPreferences sharedPrefs ;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return Scaffold(

    backgroundColor: AppColors.white,

     body:
     AnnotatedRegion<SystemUiOverlayStyle>(
       value: SystemUiOverlayStyle(
         statusBarColor: Colors.white,

       ),child:Center(
    child:  SingleChildScrollView(child:   Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
           children: [

             isLoading? const Center(
               child: CircularProgressIndicator(color: AppColors.colorPrimary,),
             ): const SizedBox(),
          //  Spacer() ,

             Padding(padding: const EdgeInsets.only(bottom: 50.0 ,top: 50) , child: Image.asset(Images.logoLarge ,height: 120, )),
             PhoneView(hint: getTranslated("phone", context)??"", edTxtController: phoneEd ,onCountryClick:(String code){
               // print("signup" +phoneCode) ;
               phoneCode = "+$code"  ;
             }, ),
             PassEditText(hint: getTranslated("password", context)??"", preIcon: Images.pass, edTxtController: passEd ,sufIcon:Images.passEye ,),
             Padding(
           padding:
           const EdgeInsets.only( left: 8, right: 8 ,),child:  Row(children: [
      Expanded(child:CheckboxListTile(
           title: Text(getTranslated("remember_me", context)??"" ,style: TextStyle(fontSize: 12),),
           value: rememberMe,
           activeColor: AppColors.colorPrimary,
           onChanged: (newValue) {
             setState(() {
               rememberMe = newValue!;
             });
           },
           controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
      ) ),
        // Spacer() ,
         TextButton(onPressed: null, child:Text( getTranslated("forget_pass", context)??"",style: TextStyle(fontSize: 12),))  ,
       ],)) ,
  /*  Padding(
    padding:
    const EdgeInsets.only( left: 8, right: 8 ,bottom: 30),child:  Align(
    alignment: Alignment.centerRight,
    child:    TextButton(onPressed: (){
               Navigator.push( context,
                   MaterialPageRoute(builder: (context) => ForgetPassword())) ;
             }, child: Text(getTranslated('forget_pass', context)??"" , style:  TextStyle(color:AppColors.colorPrimary), ))) ),*/
        Padding(padding: EdgeInsets.only(top: 40) ,child: CustomBtn(buttonNm: getTranslated("login", context)??"", onClick: onLoginBtn ,  backBtn:AppColors.buttonBk, txtColor: AppColors.white,),)




         ,Center(child:    Row(children: [
         Spacer(),

               Text(getTranslated("haven't_acc", context)??"" ,style: TextStyle(fontSize: 12),) ,
    TextButton(onPressed: (){
     Navigator.push( context,
          MaterialPageRoute(builder: (context) => Signup())) ;
    }, child: Text(getTranslated('signup', context)??"" ,  style:  TextStyle(color:AppColors.buttonBk ,fontSize: 12))) ,
         //  Spacer()
               Text(getTranslated("now", context)??"" ,style: TextStyle(fontSize: 12), ) ,
                 Spacer()

  ],) ),

           ],)),
   )));
  }
  onLoginBtn(){
    api.checkInternet(onConnect: () {
      setState(() {
        String phone  = phoneEd.text ;
        String password  = passEd.text ;
        setState(() {
          bool isValidate =   loginValidation(phone ,password)  ;
          if(isValidate){
            isLoading = true  ;
            User user  = User.login(phone,phoneCode, password) ;
            api.request(url: Constants.LOGIN_URL, map:user.toMap()  , onError:  (String errorMsg
                ){
              CustomDialog.dialog(context: context, title: "", message: errorMsg, isCancelBtn: false) ;
            }

                , onSuccess:onLoginSuccess
            );

          }
          else{
            CustomDialog.dialog(context: context, title: "", message: getTranslated("fill_data", context)??"", isCancelBtn: false) ;

                 }
        });

      });
    },notConnect: (){
      CustomDialog.dialog(context: context  , title:getTranslated("error" , context)??"error"
          , isCancelBtn: false ,message:getTranslated("no_internet" , context)??"No Internet Connection"  , onOkClick: (){} ) ;

    });

  }
void onLoginSuccess (var  jsonObj ) {
  var jsonStr = json.decode(jsonObj);
  print(jsonStr) ;
  setState(() {
    isLoading = false ;
  });
  String  msg  = jsonStr['msg']  ;
  print(msg) ;
  if(msg=="succes"){
    var  userObj  = jsonStr['user_info']  ;
print(userObj)  ;
     User user =User.fromJson(userObj, passEd.text) ;
  setState(() {
    saveUserData(user);
    Navigator.pushReplacement( context,
        MaterialPageRoute(builder: (context) => Home())) ;
  });
  }
  else{

    CustomDialog.dialog(context: context, title: getTranslated("error" , context)??"error", message: msg, isCancelBtn: false) ;

  }
}
bool loginValidation (String name  , String password){
  if(name.isEmpty) {
    return false  ;
  }
  else if(password.isEmpty){
    return false  ;
  }
  else{
    return true ;
  }

}
void saveUserData (User user )async {
  sharedPrefs = await SharedPreferences.getInstance();
  // Setting setting  = Setting(currency:"ريال"  , discountIsPer: true , priceWTax:false , taxPer:15.0 ) ;
  //sharedPrefs.setString("setting", json.encode(setting.toJsonShared()) );
  sharedPrefs.setString("user", json.encode(user.toJson()) );
}



}