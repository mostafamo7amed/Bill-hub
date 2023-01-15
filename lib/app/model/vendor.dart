class Vendor{
  String? uid;
  String? name;
  String? email;
  String? phone;
  String? companyName;
  String? companyType;
  String? employment;
  bool? isBlocked;
  String? blockReason;

  Vendor(this.uid, this.name,this.email, this.phone, this.companyName, this.companyType,
      this.employment, this.isBlocked, this.blockReason);


  Vendor.fromMap(Map<String,dynamic> map){
    name = map['name'];
    uid = map['id'];
    email = map['email'];
    phone = map['phone'];
    companyName = map['companyName'];
    companyType = map['companyType'];
    employment = map['employment'];
    isBlocked = map['isBlocked'];
    blockReason = map['blockReason'];
  }


  Map<String,dynamic>? toMap(){
    return {
      'name':name,
      'email':email,
      'id':uid,
      'phone':phone,
      'companyName':companyName,
      'companyType':companyType,
      'employment':employment,
      'isBlocked':isBlocked,
      'blockReason':blockReason,
    };
  }
}