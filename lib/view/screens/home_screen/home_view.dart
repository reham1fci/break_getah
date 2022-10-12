import 'package:flutter/material.dart';
import 'package:upgrader/upgrader.dart';

import 'widgets/home_body.dart';

class Home extends StatelessWidget{
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appcastURL = 'https://www.marsalogistics.com/new/marsadelivery/appcast.xml';
    final cfg = AppcastConfiguration(url: appcastURL, supportedOS: ['android']);

    // TODO: implement build
    return  UpgradeAlert(
        /*shouldPopScope: () => true,
        countryCode: "sa",
        appcastConfig: cfg,
        debugLogging: true,*/
        child:HomeBody()
    );
  }
}