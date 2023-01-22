class Complaint {
  String? id;
  String? title;
  String? userName;
  String? userId;
  String? userType;
  String? description;
  bool? status;
  String? date;
  String? reply;

  Complaint(this.id, this.title, this.userName, this.userType, this.description,
      this.status, this.reply,this.date,this.userId);

  Complaint.fromMap(Map<String,dynamic> map){
    id = map['id'];
    title = map['title'];
    userName = map['userName'];
    userType = map['userType'];
    description = map['description'];
    status = map['status'];
    reply = map['reply'];
    date = map['date'];
    userId = map['userId'];
  }


  Map<String,dynamic>? toMap() {
    return {
      'id': id,
      'title': title,
      'userName': userName,
      'userType': userType,
      'description': description,
      'status': status,
      'reply': reply,
      'date': date,
      'userId': userId,
    };
  }
}