class Rest {
  String? image  ;
  String? name  ;
  String? address  ;
  String? lat  ;
  String? lng  ;
String?phoneCode ;
String?phone ;
String?restId ;

  Rest({this.image, this.name, this.address, this.lat, this.lng, this.phoneCode,this.restId ,
      this.phone});
  factory Rest.fromJson (Map<String  ,dynamic> json ,  String image , ){
    return
      Rest(

        image: image ,
        phone:  json["resting_phone"] ,
        restId:  json["resting_id"] ,
        address: json["resting_address"],
        lat: json["lat"],
        lng: json["lng"],
        phoneCode:json["key_phone"] ,
        name:json["resting_name"] ,

      );
  }
  Map restToMap(String user_id) {
    var map = <String, dynamic>{};
    map["resting_phone"]  = phone ;
    map["key_phone"]  = phoneCode ;
    map["resting_name"]  = name;
    map["lat"]  = lat;
    map["lng"]  = lng;
    map["resting_address"]  = address;
    map["user_id"]  = user_id;
    return map;
  }

}