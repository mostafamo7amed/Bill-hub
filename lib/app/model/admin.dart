class Admin{
  String? id;
  String? email;

  Admin(this.id, this.email);

  Admin.fromMap(Map<String,dynamic> map){
    id = map['id'];
    email = map['email'];
  }
}