
import 'dart:convert';

import 'package:break_getah/localization/language_constrants.dart';
import 'package:break_getah/model/User.dart';
import 'package:break_getah/utill/app_color.dart';
import 'package:break_getah/utill/app_constant.dart';
import 'package:break_getah/utill/app_images.dart';
import 'package:break_getah/view/base/PassEditText.dart';
import 'package:break_getah/view/base/alert_dialog.dart';
import 'package:break_getah/view/base/custom_button.dart';
import 'package:break_getah/view/screens/PlacePicker/place_picker.dart';
import 'package:break_getah/view/screens/login/widgets/phone_view.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../ApiConnection/Api.dart';
import '../../../base/EditText.dart';
class SignupBody extends StatefulWidget{
  const SignupBody({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
  return SignupBodyState();
  }

}
class SignupBodyState extends State<SignupBody> {
  bool isLoading = false  ;
  TextEditingController userNameEd  =  TextEditingController()  ;
  TextEditingController passEd  =  TextEditingController()  ;
  TextEditingController nameEd  =  TextEditingController()  ;
  TextEditingController phoneEd  =  TextEditingController()  ;
  TextEditingController emailEd  =  TextEditingController()  ;
  TextEditingController confirmPassEd  =  TextEditingController()  ;
  String? lat , lng ;
  String address = "" ;
  bool passErrEnable = false ;
  String phoneCode = "+966" ;
  Api api = Api() ;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: AppColors.white,
      body:AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.white,

        ),child:Center(

          child:    SingleChildScrollView(child:   Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //Spacer() ,
              isLoading? const Center(
                child: CircularProgressIndicator(),
              ): const SizedBox(),
              Padding(padding: const EdgeInsets.only(bottom: 50.0 ,top: 50) , child: Image.asset(Images.logoLarge ,height: 120, )),

              // Spacer() ,
              EditText(hint: getTranslated("user_name", context)??"", imageStr:Images.user, edTxtController: userNameEd , ),
              EditText(hint: getTranslated("email", context)??"", imageStr:Images.email, edTxtController: emailEd , ),
              PhoneView(hint: getTranslated("phone", context)??"", edTxtController: phoneEd ,onCountryClick:(String code){
               // print("signup" +phoneCode) ;
                phoneCode = "+$code"  ;
              }, ),
              PassEditText(hint: getTranslated("password", context)??"", preIcon: Images.pass, edTxtController: passEd ,sufIcon:Images.passEye ,),
              PassEditText(hint: getTranslated("conf_pass", context)??"", preIcon: Images.pass, edTxtController: confirmPassEd ,sufIcon:Images.passEye ,),
          passErrEnable?    Text(getTranslated("password_match", context)??"" ,style: TextStyle(color: Colors.red,fontSize: 12),):SizedBox(height: 0,) ,
              //   Spacer() ,

             Center(child:TextButton.icon(onPressed: onDefineLocation ,icon:Image.asset(Images.location) , label: Text(getTranslated("define_location", context)??"",)) ),
              Padding(padding: EdgeInsets.only(top: 30) ,child: CustomBtn(buttonNm: getTranslated("signup_title", context)??"", onClick: onSignUpClick,  backBtn:AppColors.buttonBk, txtColor: AppColors.white,),)

            /*  Row(children: [
                Spacer(),

                Text(getTranslated("have_acc", context)??"" ) ,
                TextButton(onPressed: (){
                  Navigator.push( context,
                      MaterialPageRoute(builder: (context) => Login())) ;
                }, child: Text(getTranslated('login', context)??"" ,  style:  TextStyle(color:AppColors.logRed ))) ,
                Spacer()

              ],)*/

            ],))),
      ));  }

  onSignUpClick(){
    setState(() {
      String userNm= userNameEd.text ;
      String password  = passEd.text ;
      String conPass  = confirmPassEd.text ;
      String phone  = phoneEd.text ;
      String email  = emailEd.text ;
      if(validation(confirmPass: conPass , email:email  ,pass: password , phone:phone  , userName: userNm )){
        if(password == conPass) {
          User c = User(userName: userNm,
              name: userNm,
              userPassword: password,
              lat: lat,
              lng: lng,
              createLocation: address,
              email: email,
              phone: phone,
              phoneCode: phoneCode);
          api.request(url: Constants.SIGNUP_URL,
              map: c.signupMap(),
              onSuccess: onRequestSuccess,
              onError: (error) {});
        } else{
setState(() {
  passErrEnable = true  ;
});        }
        }
      else{
        CustomDialog.dialog(context: context, title: "", message: getTranslated("fill_data", context)??"", isCancelBtn: false) ;

      }
    });

  }
  onRequestSuccess(var  jsonStr ) {
    var jsonObj = json.decode(jsonStr);


    String  msg  = jsonObj['msg']  ;
      CustomDialog.dialog(context: context, title: "", message:msg, isCancelBtn: false ,onOkClick: (){
        Navigator.of(context).pop();

      }) ;



  }
  bool validation ({String? userName , String? pass , String? email , String? phone , String? confirmPass }  ) {
    if (userName!.isEmpty || pass!.isEmpty || email!.isEmpty || address.isEmpty || phone!.isEmpty ||confirmPass!.isEmpty) {
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