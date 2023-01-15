import 'dart:async';
import 'package:bill_hub/app/modules/onboarding_view/boarding_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../shared/components/component.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/constants_manager.dart';
import '../admin/home/home_admin.dart';
import '../buyer/home/home_buyer_view.dart';
import '../login/login_view.dart';
import '../vendor/home/home_vendor_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _splashDelay();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Center(child: Image.asset(ImageAssets.splashLogo)),
    );
  }

  _splashDelay() {
    _timer = Timer( const Duration(seconds: AppConstants.splashDelay), _goNext);
  }

  _goNext() {
    if(CacheHelper.getData(key: 'onBoarding')!=null){
      if(CacheHelper.getData(key: 'uid')!=null){
        uid = CacheHelper.getData(key: 'uid');
        print(uid);
      }
      if(uid.isNotEmpty){
        findUser(uid, context);
      }else{
        navigateAndFinish(context, LoginView());
      }
    }else{
      navigateAndFinish(context, OnBoardingScreen());
    }
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  findUser(String UID,context){
    FirebaseFirestore.instance.collection('admin').where('id',isEqualTo: UID).get().then((value) {
      print(value.docs.toString());
      if(value.docs.isNotEmpty){
        navigateAndFinish(context, AdminHomeView());
      }else{
        FirebaseFirestore.instance.collection('Vendor').where('id',isEqualTo: UID).get().then((value) {
          print(value.docs.toString());
          if(value.docs.isNotEmpty){
            navigateAndFinish(context, HomeVendorView());
          }else{
            FirebaseFirestore.instance.collection('Buyer').where('id',isEqualTo: UID).get().then((value) {
              print(value.docs.toString());
              if(value.docs.isNotEmpty){
                navigateAndFinish(context, HomeBuyerView());
              }
            }).catchError((e){

            });
          }
        }).catchError((e){

        });
      }
    }).catchError((e){

    });
  }

}
