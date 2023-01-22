class MessageModel {
  String? text;
  String? sender;
  String? receiver;
  String? dateTime;


  MessageModel({
    this.text,
    this.sender,
    this.receiver,
    this.dateTime,

 });

  MessageModel.fromMap(Map<String,dynamic> map){
    text = map['text'];
    dateTime = map['dateTime'];
    receiver = map['receiver'];
    sender = map['sender'];
  }

  Map<String,dynamic>? toMap(){
    return {
      'text':text,
      'sender':sender,
      'receiver':receiver,
      'dateTime':dateTime,
    };
  }


}