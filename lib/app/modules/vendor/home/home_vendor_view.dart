import 'package:bill_hub/app/modules/vendor/product/product.dart';
import 'package:bill_hub/shared/network/local/cache_helper.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../shared/components/component.dart';
import '../../../../styles/icons_broken.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/font_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/styles_manager.dart';
import '../../login/login_view.dart';
import '../analysis/analysis.dart';
import '../chat/chat_view.dart';
import '../complaint/complaint.dart';
import '../edit_profile/edit_vendor_account.dart';
import '../invoice/invoice_cubit/cubit.dart';
import '../invoice/invoice_cubit/states.dart';
import '../invoice/invoice_view.dart';

class HomeVendorView extends StatelessWidget {
  const HomeVendorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    InvoiceCubit.getCubit(context).getVendorData(CacheHelper.getData(key: 'uid'));
    return BlocConsumer<InvoiceCubit,InvoiceStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit  = InvoiceCubit.getCubit(context);
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  CacheHelper.removeData(key: 'uid');
                  uid = '';
                  print(CacheHelper.getData(key: 'uid'));
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
          body: ConditionalBuilder(
            condition: cubit.vendorModel!=null,
            builder: (context) => Column(
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
                          // navigateTo(context, EditVendorAccount());
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
                          if(cubit.vendorModel!=null)
                            Text('${cubit.vendorModel!.email}',
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
                                  "أنشاء فاتورة جديدة",
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
                    navigateTo(context, InvoiceVendorView());
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
                            padding: EdgeInsets.all(10.0),
                            child:Icon(IconBroken.Buy,size: 32,color: ColorManager.primary,),
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
                                  "المنتجات",
                                  style: getSemiBoldStyle(
                                      color: ColorManager.black, fontSize: 18),
                                ),
                                Text(
                                  "قم بإضافة منتج جديد",
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
                    navigateTo(context, ProductView());
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
                    navigateTo(context,  ChatView());
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
                            child: Icon(IconBroken.Chart,size: 32,color: ColorManager.primary,),
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
                                  "تحليل المبيعات",
                                  style: getSemiBoldStyle(
                                      color: ColorManager.black, fontSize: 18),
                                ),
                                Text(
                                  "بيانات مبيعاتك عن كل شهر",
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
                    navigateTo(context,  AnalysisView());
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
                    navigateTo(context,  VendorComplaint());
                  },
                ),
              ],
            ),
            fallback: (context) => Center(
              child: CircularProgressIndicator(
                strokeWidth: 3,
                backgroundColor: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }
}
