class Buyer {
  String? uid;
  String? name;
  String? email;
  String? phone;

  Buyer(this.uid, this.name, this.email, this.phone);


  Buyer.fromMap(Map<String,dynamic> map){
    name = map['name'];
    uid = map['id'];
    email = map['email'];
    phone = map['phone'];
  }


  Map<String,dynamic>? toMap(){
    return {
      'name':name,
      'email':email,
      'id':uid,
      'phone':phone,
    };
  }
}