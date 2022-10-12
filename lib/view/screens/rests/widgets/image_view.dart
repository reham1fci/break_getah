
import 'package:break_getah/utill/app_images.dart';
import 'package:flutter/material.dart';
class ImageView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
  return _State();
  }

}
class _State extends State<ImageView> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
return
 Padding(padding:  EdgeInsets.only(top: 40),child: Container(
    width: 150,
    height: 100,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(width: 1.0, color: const Color(0x87707070)),
    ),
    child: Center(child: IconButton(onPressed: null, icon: Image.asset(Images.camera)),),
  ) );
  }

}