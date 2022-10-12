
import 'package:break_getah/localization/language_constrants.dart';
import 'package:break_getah/utill/app_color.dart';
import 'package:break_getah/utill/app_images.dart';
import 'package:break_getah/view/screens/home_screen/home_view.dart';
import 'package:break_getah/view/screens/login/login_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashBody extends StatefulWidget{
  const SplashBody({Key? key}) : super(key: key);

  @override
  State<SplashBody> createState() => _SplashBodyState();
}

class _SplashBodyState extends State<SplashBody> {
  late SharedPreferences sharedPrefs ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(
        const Duration(seconds: 3),
            () => checkUser()
    );
  }
  checkUser() async {
    sharedPrefs = await SharedPreferences.getInstance();

    if(sharedPrefs.containsKey("user")){


     Navigator.pushReplacement( context, MaterialPageRoute(builder: (context) => Home())) ;


      // api.login( onError:  onError, onLogin:
      //  onLogin, password: user.password , username: user.userName ) ;
    }
    else{
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>    Login()),) ; }
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Scaffold( backgroundColor:AppColors.splashBackground,
    body:AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: AppColors.splashBackground,

        ),child:Center( child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
    const   Spacer(),

   Center(child: Image.asset(Images.splashLogo,
   // fit: BoxFit.fitWidth,
    repeat: ImageRepeat.noRepeat,
    )),
    const   Spacer(),
    //  padding:const EdgeInsets.all(100),) ,



    ]),
    ) ));
  }
}