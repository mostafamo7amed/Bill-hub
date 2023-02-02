import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../shared/components/component.dart';
import '../../../../styles/icons_broken.dart';
import '../../../model/users.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/styles_manager.dart';
import '../../chat_bloc/cubit.dart';
import '../../chat_bloc/states.dart';
import '../home/buyer_cubit/cubit.dart';
import 'add_new_chat.dart';
import 'chats_details_view.dart';

class ChatBuyerView extends StatefulWidget {
  const ChatBuyerView({Key? key}) : super(key: key);

  @override
  State<ChatBuyerView> createState() => _ChatBuyerViewState();
}

class _ChatBuyerViewState extends State<ChatBuyerView> {

  @override
  void initState() {
    ChatCubit.getCubit(context)
        .getChat(userType: 'Buyer', userId: BuyerCubit.getCubit(context).buyerModel!.uid!);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit,ChatStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        var cubit = ChatCubit.getCubit(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'المحادثات',
              style: getSemiBoldStyle(color: ColorManager.white, fontSize: 20),
            ),
          ),
          body: Column(
            children: [
              Container(
                decoration: BoxDecoration(color: ColorManager.primary,
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(4),bottomLeft:Radius.circular(4) )
                ),
                child: InkWell(
                  onTap: () {
                    navigateTo(context, AddNewChat());
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('أضافة محادثة',style: getSemiBoldStyle(color: ColorManager.white, fontSize: 16)),
                        SizedBox(width: 4,),
                        Icon(IconBroken.Add_User,color: ColorManager.white,),

                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ConditionalBuilder(
                  condition: cubit.users.isNotEmpty,
                  builder: (context) => ListView.separated(
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) =>
                          buildChatItem(cubit.users[index],context),
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 5,
                      ),
                      itemCount: cubit.users.length),
                  fallback: (context) => Center(
                      child: Text(
                        'لا توجد محادثات',
                        style: getSemiBoldStyle(color: ColorManager.black, fontSize: 16),
                      ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildChatItem(Users model, context) => InkWell(
    onTap: () {
      navigateTo(
          context,
          ChatsDetailsBuyerView(
              model, BuyerCubit.getCubit(context).buyerModel!.uid!));
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
                  '${model.name}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: getSemiBoldStyle(color: ColorManager.black,fontSize: 18
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
          ),
        ],
      ),
    ),
  );
}
