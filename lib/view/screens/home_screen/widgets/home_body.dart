
import 'dart:convert';
import 'dart:ui';

import 'package:break_getah/ApiConnection/Api.dart';
import 'package:break_getah/localization/language_constrants.dart';
import 'package:break_getah/model/User.dart';
import 'package:break_getah/model/rest.dart';
import 'package:break_getah/utill/app_color.dart';
import 'package:break_getah/utill/app_constant.dart';
import 'package:break_getah/utill/app_images.dart';
import 'package:break_getah/view/screens/home_screen/widgets/home_buttons.dart';
import 'package:break_getah/view/screens/home_screen/widgets/icon_btn.dart';
import 'package:break_getah/view/screens/home_screen/widgets/rest_item.dart';
import 'package:break_getah/view/screens/rests/add_rest.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
class HomeBody extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
  return _State();
  }

}
class _State extends State<HomeBody> {
  Color backgroundColor  = AppColors.white;
  List<Rest> restList=[]  ;
  User? user ;
  bool loading = true  ;
  Rest currentRest  = Rest(name: "test" , image:Images.placeBCk  ) ;
  Api api  = Api ()  ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   getUserData()  ;
  }
  getUserData() async {
    SharedPreferences  shared = await SharedPreferences.getInstance();
    user = User.fromJsonShared(json.decode(shared.getString("user")!));
getRequestsList()  ;
  }
  getRequestsList() async {
    restList =[];
    Map m  = {"user_id":user!.userId } ;
    print(m) ;
    await     api.request(url:Constants.GETRESTS, map: m, onSuccess: onSuccess, onError: onError) ;

  }

  onSuccess(var jsonStr){
    print(jsonStr);
    List<dynamic> jsonArr = json.decode(jsonStr);
    for (int i = 0 ; i < jsonArr.length ; i ++){
      var   jsonObj=jsonArr [i];
      Rest  req = Rest.fromJson(jsonObj , Images.placeBCk);
      setState(() {
        restList.add(req);


      });

    }
    setState(() {
      loading= false ;
      if(restList.isNotEmpty){
      currentRest  = restList[0] ;}
    });


  }

  onError(String err){
    print(err) ;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
        Scaffold(
          appBar: AppBar(
          //  iconTheme: IconThemeData(color: Colors.grey),
            backgroundColor: AppColors.white  ,
            centerTitle: false,
            systemOverlayStyle:const SystemUiOverlayStyle(
              // Status bar color
              statusBarColor: AppColors.statusAppBar,),
            title: Image.asset(Images.logo , width: 40,height:40,),),
          backgroundColor:backgroundColor ,
          body: Column(children: [
          Expanded(child:  Container( decoration: BoxDecoration(
             image: DecorationImage(
                  image: AssetImage( currentRest.image! ,),
                   fit: BoxFit.cover,
                ),),
          )),
            Container(height: 100,
    width: double.infinity,
    decoration: BoxDecoration(
    image: DecorationImage(
    image: AssetImage(  Images.greyBk ,),
    fit: BoxFit.cover,
    ),) ,
    child: ClipRRect( // make sure we apply clip it properly
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    padding: EdgeInsets.only(top: 10),
                    alignment: Alignment.center,
                    color: Colors.black.withOpacity(0.1),
                    child:
                    Column(children: [
                      Text(
                        currentRest.name! ,
                        style: TextStyle(fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColors.white
                        ),
                      ),
                      Row(children: [
                        Spacer() ,
IconBtn(buttonIcon: Images.group,text: "29", onClick: (){},),
IconBtn(buttonIcon: Images.star,text: "89", onClick: (){},),
IconBtn(buttonIcon: Images.money,text: "300", onClick: (){},),
                        Spacer() ,

                      ],)
                    ],)
                  ),
                ),
              ),
            ) ,
            Expanded(child:  Container(
              child: Column(children: [
    Padding(padding : EdgeInsets.all(8) ,child:      Row(
                  children: [
                   Padding(padding: EdgeInsets.only(right: 2 ,left: 2) ,child: HomeButtons(text:getTranslated("my_rest", context) ,onClick: (){},),),
                       Padding(padding: EdgeInsets.only(right: 2 ,left: 2) ,child:    HomeButtons(text:getTranslated("top_rated", context) ,onClick: (){},)),
    Padding(padding: EdgeInsets.only(right: 2 ,left: 2) ,child:    HomeButtons(text:getTranslated("most_budgetary", context) ,onClick: (){},)),
    Padding(padding: EdgeInsets.only(right: 2 ,left: 2) ,child:    HomeButtons(text:getTranslated("most_budgetary", context) ,onClick: (){},)) ,
                    IconButton(onPressed: (){

                      showDialog<void>(
                          context: context,
                          barrierDismissible: false, // user must tap button!
                          builder: (BuildContext context) {
                            return AddRest();
                          }).then((value) {
                            getRequestsList() ;
                      });
                    }, icon: Icon(Icons.add_circle_outline)) ,
                  ],
                )) ,


                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: restList.length,
                    itemBuilder: (BuildContext context, int index){
                      return RestItem(item: restList[index], index: index ,onTap: (){

                        setState(() {
                          currentRest  = restList[index] ;

                        });
                      },) ;
                    }
                  ),
                ),
              ],),
            ) ),
          ],) ,
        ) ;
  }

}