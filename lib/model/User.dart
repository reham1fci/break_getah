
class User {
  String? userId  ;
  String?userName  ;
  String? name  ;
  String? userPassword  ;
  String? email  ;
  String? phone  ;
  String? lat;
  String? lng;
  String? createLocation;
  String? idNum;
  String? salary ;
  String?salaryDate;
  String? vacation;
  String? housingAllowance;
  String? transAllowance;
  String? passEndDate;
  String? insuranceCardEndDate;
  String? insuranceEndDate;
  String? employeeDate;
  String? employeeEndDate;
  String? testPeriod;
  String? employeeTarget;
  String? phoneCode;
  String? licenceEndDate;
  String? shipmentQty  ;
  bool?admin ;
  String? empType ;


  User({this.userId, this.userName, this.userPassword, this.name, this.phone , this.lng ,this.admin, this.lat , this.createLocation,this.employeeDate,this.employeeEndDate,this.email,this.salaryDate , this.empType ,this.phoneCode
 , this.employeeTarget ,this.housingAllowance ,this.idNum,this.insuranceCardEndDate,this.insuranceEndDate,this.passEndDate,this.salary,this.testPeriod,this.transAllowance,this.vacation,this.licenceEndDate ,this.shipmentQty});

  factory User.fromJson (Map<String  ,dynamic> json ,  String password , ){
    return
      User(

        userName: json["user_name"] ,
        phone:  json["user_phone"] ,
        userId:  json["user_id"]  ,
        email: json["user_email"]  ,
        createLocation: json["user_address"],
        lat: json["lat"],
        lng: json["lng"],
        empType:json["user_type"] ,
        userPassword: password  ,

      );
  } factory User.fromJsonProfile (Map<String  ,dynamic> json  ){
    return
      User(

        name: json["name"] ,userId: json["user_id"],
        vacation: json["employ_vac"]  ,
        idNum:  json["id_num"]  ,
        salary:   json["employ_salary"] ,
        transAllowance: json["trans_allowance"]   ,
        housingAllowance: json["housing_allowance"] ,
        employeeDate:json["date_employment"]  ,
        employeeEndDate:json["work_end_date"]  ,
        employeeTarget: json["employ_target"] ,
        insuranceCardEndDate:json["date_insurance_end"]  ,
        insuranceEndDate:json["date_insurance_end2"]  ,
        passEndDate: json["date_pass_end"] ,
        testPeriod:json["fatra_tagreeb"]  ,
        licenceEndDate: json["date_license_end"]

      );
  }
  factory User.fromJsonShared (Map<String  ,dynamic> json ){
    return User(
        userName: json["userName"] ,
        phone:   json["phone"],
        userId:  json["userId"]  ,
        userPassword:  json["password"]  ,
      empType: json["employ_type"],
      createLocation: json["address"],
      lat: json["lat"],
      lng: json["lng"]

    );
  }
  factory User.fromJsonSalary(Map<String  ,dynamic> json ){
    return User(

      salary: json["salary_safy"] ,
      salaryDate:   json["date"],


    );
  } factory User.fromJsonEmployee(Map<String  ,dynamic> json ){
    return User(

      name: json["name"] ,
      userId:   json["user_id"],


    );
  }
factory User.fromJsonReturn(Map<String  ,dynamic> json ){
    return User(

      name: json["driver_name"] ,
      shipmentQty:   json["amount"],
      userId:   json["delivery_id"],


    );
  }

  Map<String, dynamic> toJson( ) {
    return {
      "userId": userId,
      "userName":userName ,
      "password":userPassword ,
      "phone": phone,
      "employ_type":empType,
      "email":email,
      "lat":lat,
      "lng":lng,
      "address":createLocation

    };
  }

  User.login( this.phone,this.phoneCode , this.userPassword );
  Map toMap() {
    var map = <String, dynamic>{};
    map["user_phone"]  = phone ;
    map["key_phone"]  = phoneCode ;
    map["password"]  = userPassword;
    return map;
  } Map toMapTest() {
    var map = <String, dynamic>{};
    map["username"]  = "1057" ;
    map["password"]  = "1111";
    map["org_id"]  = "001";
    return map;
  } Map signupMap() {
    var map = <String, dynamic>{};
    map["user_name"]  = userName ;
    map["password"]  = userPassword;
    map["key_phone"]  = phoneCode;
    map["user_phone"]  = phone;
    map["user_email"]  = email;
    map["lat"]  = lat;
    map["lng"]  = lng;
    map["user_address"]  = createLocation;
    return map;
  }

  Map addLocationToMap() {
    var map = <String, dynamic>{};
    map["lat"]  = lat ;
    map["lng"]  = lng;
    map["user_id"]  = userId;
    map["createdDate"]  = createLocation;
    return map;
  }



  static List<User>? fromJsonList(List list) {
    if (list == null) return null;
    return list.map((item) => User.fromJsonEmployee(item)).toList();
  }
}