import 'package:flutter/material.dart';

import '../../../../shared/components/component.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/styles_manager.dart';
import 'chats_details_view.dart';

class ChatView extends StatelessWidget {
  const ChatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'المحادثات',
          style: getSemiBoldStyle(color: ColorManager.white, fontSize: 20),
        ),
      ),
      body: ListView.separated(
        physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) =>
              buildChatItem(context),
          separatorBuilder: (context, index) => const SizedBox(
            height: 5,
          ),
          itemCount: 10),
    );
  }
  Widget buildChatItem( context) => InkWell(
    onTap: () {
      navigateTo(context, ChatsDetailsView());
    },
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            //backgroundImage: NetworkImage('${model.image}'),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'احمد علي',
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
