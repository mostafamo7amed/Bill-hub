import 'package:bill_hub/app/resources/color_manager.dart';
import 'package:bill_hub/app/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../styles/icons_broken.dart';
import '../../../model/message_model.dart';
import '../../../model/users.dart';
import '../../../resources/assets_manager.dart';
import '../../chat_bloc/cubit.dart';
import '../../chat_bloc/states.dart';


class ChatsDetailsView extends StatelessWidget {
  Users user;
  String senderId;
  ChatsDetailsView(this.user,this.senderId,{super.key});
  final chatController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        ChatCubit.getCubit(context).getMessage(receiverId: user.id!,senderId:senderId,userType:'Vendor');
        return BlocConsumer<ChatCubit,ChatStates>(
          listener: (context, state) {} ,
          builder: (context, state) {
            var chatCubit = ChatCubit.getCubit(context);
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 23,
                          backgroundImage: AssetImage(ImageAssets.photo),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${user.name}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: getSemiBoldStyle(color: ColorManager.white,fontSize: 18
                              ),
                            ),
                            Text(
                              'منذ قليل',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: getLightStyle(color: ColorManager.darkGray,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              var messages = chatCubit.messages[index];
                              if (messages.sender== senderId) {
                                return buildSenderMessage(messages,context);
                              } else {
                                return buildReceiverMessage(messages,context);
                              }
                            },
                            separatorBuilder: (context, index) =>
                            const SizedBox(
                              height: 10,
                            ),
                            itemCount: chatCubit.messages.length,),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: chatController,
                              maxLines: null,
                              style: getRegularStyle(color: ColorManager.black,fontSize: 16),
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 5),
                                hintText: 'اكتب شئ ...',
                                border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return '';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.text,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                chatCubit.sendMessage(
                                  receiverId: user.id!,
                                  text: chatController.text,
                                  dateTime: DateTime.now().toString(),
                                  senderId: senderId,
                                  senderType: 'Vendor',
                                  receiverType: user.type!,

                                );
                                chatController.text = '';
                              }
                            },
                            icon: Icon(
                              IconBroken.Send,
                              color: ColorManager.primary,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget buildSenderMessage(MessageModel messageModel, context) {
    DateTime time = DateTime.parse(messageModel.dateTime!);
    String formattedTime = DateFormat('kk:mm a').format(time);

    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: const BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadiusDirectional.only(
            topEnd: Radius.circular(10),
            topStart: Radius.circular(10),
            bottomEnd: Radius.circular(10),
          ),
        ),
        child: Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 14.0),
              child: Text(
                '${messageModel.text}',
                style: getRegularStyle(color: ColorManager.black,fontSize: 16),
              ),
            ),
            Text(
              '${formattedTime}',
              style: Theme.of(context).textTheme.caption!.copyWith(
                    height: 1.3,
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildReceiverMessage(MessageModel messageModel,context) {
    DateTime time = DateTime.parse(messageModel.dateTime!);
    String formattedTime = DateFormat('kk:mm a').format(time);
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          color: ColorManager.lightPrimary,
          borderRadius: BorderRadiusDirectional.only(
            topEnd: Radius.circular(10),
            topStart: Radius.circular(10),
            bottomStart: Radius.circular(10),
          ),
        ),
        child: Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 14.0),
              child: Text(
                '${messageModel.text}',
                style: getRegularStyle(color: ColorManager.black,fontSize: 16),
              ),
            ),
            Text(
              '${formattedTime}',
              style: Theme.of(context).textTheme.caption!.copyWith(
                height: 1.3,
                fontSize: 12,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
