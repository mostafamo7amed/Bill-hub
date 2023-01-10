import 'package:flutter/material.dart';

import '../../../../shared/components/component.dart';
import '../../../../styles/icons_broken.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/font_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/styles_manager.dart';
import '../../login/login_view.dart';
import '../chat/chat_view.dart';
import '../complaint/complaint.dart';
import '../edit_profile/edit_profile.dart';
import '../invoice/invoice_buyer_view.dart';

class HomeBuyerView extends StatelessWidget {
  const HomeBuyerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              navigateAndFinish(context, LoginView());
            },
            icon: ImageIcon(
              AssetImage(ImageAssets.shutdown),
              color: ColorManager.white,
              size: 25,
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 100,
            decoration: BoxDecoration(
              color: ColorManager.primary,
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 14.0, right: 14),
              child: Row(children: [
                InkWell(
                  onTap: () {
                    navigateTo(context, EditBuyerAccount());
                  },
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    child: CircleAvatar(
                      radius: 27,
                      backgroundImage: AssetImage(
                        ImageAssets.photo,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppStrings.welcomeVisitor,
                        style: getBoldStyle(
                            color: ColorManager.white,
                            fontSize: FontSizeManager.s22)),
                    Text('example345@example.com',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: getBoldStyle(
                            color: ColorManager.gray,
                            fontSize: FontSizeManager.s16)),
                  ],
                ),
              ]),
            ),
          ),
          InkWell(
            child: Card(
                margin: const EdgeInsets.all(5),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 3,
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(IconBroken.Document,size: 32,color: ColorManager.primary,),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(IconBroken.Arrow___Left_2,color: ColorManager.primary,),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "الفواتير",
                            style: getSemiBoldStyle(
                                color: ColorManager.black, fontSize: 18),
                          ),
                          Text(
                            "تابع فواتيرك",
                            style: getSemiBoldStyle(
                                color: ColorManager.gray, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                  ],
                )),
            onTap: () {
              navigateTo(context, InvoiceBuyerView());
            },
          ),
          InkWell(
            child: Card(
                margin: const EdgeInsets.all(5),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 3,
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(IconBroken.Chat,size: 32,color: ColorManager.primary,),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(IconBroken.Arrow___Left_2,color: ColorManager.primary,),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "المحادثات",
                            style: getSemiBoldStyle(
                                color: ColorManager.black, fontSize: 18),
                          ),
                          Text(
                            "تواصل مع العملاء بسهولة",
                            style: getSemiBoldStyle(
                                color: ColorManager.gray, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                  ],
                )),
            onTap: () {
              navigateTo(context,  ChatBuyerView());
            },
          ),
          InkWell(
            child: Card(
                margin: const EdgeInsets.all(5),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 3,
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(IconBroken.Calling,size: 32,color: ColorManager.primary,),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(IconBroken.Arrow___Left_2,color: ColorManager.primary,),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "الشكاوي",
                            style: getSemiBoldStyle(
                                color: ColorManager.black, fontSize: 18),
                          ),
                          Text(
                            "أرسال شكوي للدعم الفني",
                            style: getSemiBoldStyle(
                                color: ColorManager.gray, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                  ],
                )),
            onTap: () {
              navigateTo(context,  BuyerComplaint());
            },
          ),
        ],
      ),
    );

  }
}
