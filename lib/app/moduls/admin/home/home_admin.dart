import 'package:bill_hub/app/moduls/admin/manage_users/manage_users.dart';
import 'package:bill_hub/app/resources/color_manager.dart';
import 'package:bill_hub/app/resources/strings_manager.dart';
import 'package:bill_hub/app/resources/styles_manager.dart';
import 'package:flutter/material.dart';

import '../../../../shared/components/component.dart';
import '../../../../styles/icons_broken.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/font_manager.dart';
import '../../login/login_view.dart';

class AdminHomeView extends StatelessWidget {
  const AdminHomeView({Key? key}) : super(key: key);

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
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  child: CircleAvatar(
                    radius: 27,
                    backgroundImage: AssetImage(
                      ImageAssets.photo,
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                Text(AppStrings.welcomeVisitor,
                    style: getBoldStyle(
                        color: ColorManager.white,
                        fontSize: FontSizeManager.s24)),
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
                      child: Image.asset(ImageAssets.bill,width: 40,height: 40,),
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
                            "التحقق من الفواتير",
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
              //navigateTo(context, UserManagement());
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
                      child:Image.asset(ImageAssets.manage,width: 40,height: 40,),
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
                            "البائعين",
                            style: getSemiBoldStyle(
                                color: ColorManager.black, fontSize: 18),
                          ),
                          Text(
                            "قبول او رفض البائع",
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
              navigateTo(context, ManageUsers());
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
                      child: Image.asset(ImageAssets.complaint,width: 40,height: 40,),
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
                            "إدارة ومتابعة شكاوي العملاء",
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
              //navigateTo(context, UserManagement());
            },
          ),
        ],
      ),
    );
  }
}
