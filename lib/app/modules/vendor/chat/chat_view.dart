import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/components/component.dart';
import '../../../model/users.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/styles_manager.dart';
import '../../chat_bloc/cubit.dart';
import '../../chat_bloc/states.dart';
import '../invoice/invoice_cubit/cubit.dart';
import 'chats_details_view.dart';

class ChatView extends StatefulWidget {
  const ChatView({Key? key}) : super(key: key);

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  @override
  void initState() {
    ChatCubit.getCubit(context)
        .getAllUsers(userId: InvoiceCubit.getCubit(context).vendorModel!.uid!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ChatCubit.getCubit(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'المحادثات',
              style: getSemiBoldStyle(color: ColorManager.white, fontSize: 20),
            ),
          ),
          body: ConditionalBuilder(
            condition: cubit.users.isNotEmpty,
            builder: (context) => ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    buildChatItem(cubit.users[index], context),
                separatorBuilder: (context, index) => const SizedBox(
                      height: 5,
                    ),
                itemCount: cubit.users.length),
            fallback: (context) => Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                backgroundColor: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildChatItem(Users user, context) => InkWell(
        onTap: () {
          navigateTo(
              context,
              ChatsDetailsView(
                  user, InvoiceCubit.getCubit(context).vendorModel!.uid!));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage(ImageAssets.photo),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${user.name}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: getSemiBoldStyle(
                          color: ColorManager.black, fontSize: 18),
                    ),
                    Text(
                      'منذ قليل',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: getLightStyle(
                        color: ColorManager.darkGray,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
