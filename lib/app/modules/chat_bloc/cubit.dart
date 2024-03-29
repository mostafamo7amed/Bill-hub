import 'package:bill_hub/app/model/invoice_item.dart';
import 'package:bill_hub/app/modules/chat_bloc/states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/buyer.dart';
import '../../model/message_model.dart';
import '../../model/users.dart';
import '../../model/vendor.dart';

class ChatCubit extends Cubit<ChatStates> {
  ChatCubit() : super(ChatIntiSate());
  static ChatCubit getCubit(context) => BlocProvider.of(context);

  List<Users> users = [];

  /*void getChatUsers({
     required userType,
     userId,
     buyerPhone,
}){
    users = [];
    if(userType == "vendor"){
      FirebaseFirestore.instance
          .collection('All Invoices')
          .where('vendorId', isEqualTo: userId)
          .get()
          .then((value) {
        print('=============================== ${value.docs.length}');
        for (var element in value.docs) {
          FirebaseFirestore.instance.collection('Buyer')
              .get().then((value1) {
            for (var element2 in value1.docs) {
              Buyer buyerModel = Buyer.fromMap(element2.data());
              print('=============================== ${buyerModel.email}');
              print('===============================buyer ${InvoiceItem.fromMap(element.data()).buyerPhone}');
              if(InvoiceItem.fromMap(element.data()).buyerPhone==buyerModel.phone) {
                users.add(Users(buyerModel.uid, buyerModel.name, 'Buyer',
                    buyerModel.phone));
                emit(ChatGetAllBuyerSuccessState());
              }
            }
          });
        }
      }).catchError((e) {
        emit(ChatGetAllUsersErrorState());
      });
    }else{
      FirebaseFirestore.instance
          .collection('All Invoices')
          .where('buyerPhone', isEqualTo: buyerPhone)
          .get()
          .then((value) {
        print('=============================== ${value.docs.length}');
        for (var element in value.docs) {
          FirebaseFirestore.instance.collection('Vendor')
              .get().then((value1) {
            for (var element2 in value1.docs) {
              Vendor vendorModel = Vendor.fromMap(element2.data());
              print('=============================== ${vendorModel.email}');
              print('===============================buyer ${InvoiceItem.fromMap(element.data()).vendorId}');
              if(InvoiceItem.fromMap(element.data()).vendorId==vendorModel.uid) {
                users.add(Users(vendorModel.uid, vendorModel.name, 'Vendor',
                    vendorModel.phone));
                emit(ChatGetAllBuyerSuccessState());
              }
            }
          });
        }
      }).catchError((e) {
        emit(ChatGetAllUsersErrorState());
      });
    }

  }*/


  void getChat({
    required userType,
  required String userId,
}){
    emit(ChatGetAllUsersLoadingState());
    users = [];
    if(userType == 'Vendor'){
      FirebaseFirestore.instance
          .collection('Vendor')
          .doc(userId)
          .collection('Chats')
          .get().then((value){
        print('=============================== ${value.docs.toString()}');

        for (var element in value.docs) {
          print('=============================== ${element.id}');
          FirebaseFirestore.instance.collection('Buyer')
              .doc(element.id)
              .get().then((value1) {
            Buyer buyerModel = Buyer.fromMap(value1.data()!);
            print('=============================== ${buyerModel.email}');
            users.add(Users(
                buyerModel.uid,
                buyerModel.name,
                'Buyer',
                buyerModel.phone));
            emit(ChatGetAllBuyerSuccessState());
          });
        }
      }).catchError((e) {
          emit(ChatGetAllUsersErrorState());
      });
    }else{
      FirebaseFirestore.instance
          .collection('Buyer')
          .doc(userId)
          .collection('Chats')
          .get().then((value){
        print('=============================== ${value.docs.toString()}');
        for (var element in value.docs) {
          print('=============================== ${element.id}');
          FirebaseFirestore.instance.collection('Vendor')
              .doc(element.id)
              .get().then((value1) {
            Vendor vendorModel = Vendor.fromMap(value1.data()!);
            print('=============================== ${vendorModel.email}');
            users.add(Users(
                vendorModel.uid,
                vendorModel.name,
                'Vendor',
                vendorModel.phone));
            emit(ChatGetAllVendorsSuccessState());
          });
        }
      }).catchError((e) {
        emit(ChatGetAllUsersErrorState());
      });
    }
  }



  List<Users> vendorsList = [];
  void getAllVendor(){
    vendorsList = [];
    FirebaseFirestore.instance.collection('Vendor')
        .get().then((value1) {
      for (var element2 in value1.docs) {
        Vendor vendorModel = Vendor.fromMap(element2.data());
        vendorsList.add(Users(vendorModel.uid, vendorModel.name, 'Vendor',
              vendorModel.employment));
          emit(ChatGetAllVendorChatSuccessState());
        }
    }).catchError((e){
      emit(ChatGetAllVendorChatErrorState());
    });
  }



  /*void getAllUsers({
    required String userId,
  }) {
    users = [];
    emit(ChatGetAllUsersLoadingState());
    FirebaseFirestore.instance.collection('Vendor').get().then((value) {
      for (var element in value.docs) {
        // !=
        if (element.reference.id != userId) {
          users.add(Users(
              Vendor.fromMap(element.data()).uid,
              Vendor.fromMap(element.data()).name,
              'Vendor',
              Vendor.fromMap(element.data()).phone));
        }
      }
      emit(ChatGetAllVendorsSuccessState());
    }).catchError((e) {
      emit(ChatGetAllUsersErrorState());
    });
    FirebaseFirestore.instance.collection('Buyer').get().then((value) {
      for (var element in value.docs) {
        // !=
        if (element.reference.id != userId) {
          users.add(Users(
              Buyer.fromMap(element.data()).uid,
              Buyer.fromMap(element.data()).name,
              'Buyer',
              Buyer.fromMap(element.data()).phone));
        }
      }
      emit(ChatGetAllBuyerSuccessState());
    }).catchError((e) {
      emit(ChatGetAllUsersErrorState());
    });
  }*/

  void sendMessage({
    required String receiverId,
    required String senderId,
    required String senderType,
    required String receiverType,
    required String text,
    required String dateTime,
  }) {
    MessageModel messageModel = MessageModel(
      dateTime: dateTime,
      receiver: receiverId,
      sender: senderId,
      text: text,
    );
    if (senderType == 'Vendor') {
      FirebaseFirestore.instance
          .collection('Vendor')
          .doc(senderId)
          .collection('Chats')
          .doc(receiverId)..set({
        'typing':true
      })..collection('Messages')
          .add(messageModel.toMap()!)
          .then((value) {
        emit(ChatSendMessageSuccessState());
      }).catchError((e) {
        emit(ChatSendMessageErrorState());
      });
      FirebaseFirestore.instance
          .collection(receiverType)
          .doc(receiverId)
          .collection('Chats')
          .doc(senderId)..set({
        'typing':true
      })..collection('Messages')
          .add(messageModel.toMap()!)
          .then((value) {
        emit(ChatSendMessageSuccessState());
      }).catchError((e) {
        emit(ChatSendMessageSuccessState());
      });
    } else {
      FirebaseFirestore.instance
          .collection('Buyer')
          .doc(senderId)
          .collection('Chats')
          .doc(receiverId)..set({
          'typing':true
        })..collection('Messages')
          .add(messageModel.toMap()!)
          .then((value) {
        emit(ChatSendMessageSuccessState());
      }).catchError((e) {
        emit(ChatSendMessageErrorState());
      });
      FirebaseFirestore.instance
          .collection(receiverType)
          .doc(receiverId)
          .collection('Chats')
          .doc(senderId)..set({
        'typing':true
      })..collection('Messages')
          .add(messageModel.toMap()!)
          .then((value) {
        emit(ChatSendMessageSuccessState());
      }).catchError((e) {
        emit(ChatSendMessageSuccessState());
      });
    }
  }

  List<MessageModel> messages = [];
  void getMessage({
    required String receiverId,
    required String senderId,
    required String userType,
  }) {
    FirebaseFirestore.instance
        .collection(userType)
        .doc(senderId)
        .collection('Chats')
        .doc(receiverId)
        .collection('Messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      for (var element in event.docs) {
        messages.add(MessageModel.fromMap(element.data()));
      }
      emit(ChatGetMessageSuccessState());
    });
  }
}
