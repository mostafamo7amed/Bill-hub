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
  void getAllUsers({
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
  }

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
          .doc(receiverId)
          .collection('Messages')
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
          .doc(senderId)
          .collection('Messages')
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
          .doc(receiverId)
          .collection('Messages')
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
          .doc(senderId)
          .collection('Messages')
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
