import 'package:bill_hub/app/modules/admin/manage_users/manage_users.dart';
import 'package:bill_hub/app/resources/color_manager.dart';
import 'package:bill_hub/app/resources/strings_manager.dart';
import 'package:bill_hub/app/resources/styles_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/components/component.dart';
import '../../../../shared/network/local/cache_helper.dart';
import '../../../../styles/icons_broken.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/font_manager.dart';
import '../../login/login_view.dart';
import '../complaint/complaint_view.dart';
import '../manage_invoice/manage_invoice.dart';
import 'home_cubit/cubit.dart';
import 'home_cubit/states.dart';

class AdminHomeView extends StatelessWidget {
  const AdminHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AdminCubit.getCubit(context);
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  CacheHelper.removeData(key: 'uid');
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
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      child: CircleAvatar(
                        radius: 27,
                        backgroundImage: AssetImage(
                          ImageAssets.photo,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.welcomeVisitor,
                          style: getBoldStyle(
                              color: ColorManager.white,
                              fontSize: FontSizeManager.s22),
                        ),
                        if (cubit.adminModel != null)
                          Text(
                            '${cubit.adminModel!.email}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: getBoldStyle(
                                color: ColorManager.gray,
                                fontSize: FontSizeManager.s16),
                          ),
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
                          child: Icon(
                            IconBroken.Document,
                            size: 32,
                            color: ColorManager.primary,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            IconBroken.Arrow___Left_2,
                            color: ColorManager.primary,
                          ),
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
                  navigateTo(context, ManageAdminInvoice());
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
                          child: Icon(
                            IconBroken.User1,
                            size: 32,
                            color: ColorManager.primary,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            IconBroken.Arrow___Left_2,
                            color: ColorManager.primary,
                          ),
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
                          child: Icon(
                            IconBroken.Calling,
                            size: 32,
                            color: ColorManager.primary,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            IconBroken.Arrow___Left_2,
                            color: ColorManager.primary,
                          ),
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
                  navigateTo(context, ComplaintAdminView());
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
