import 'package:bill_hub/app/moduls/visitor/visitor_pay_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../shared/components/component.dart';
import '../../../styles/icons_broken.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/styles_manager.dart';


class VisitorView extends StatelessWidget {
  VisitorView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ضيف',style: getSemiBoldStyle(color: ColorManager.white,fontSize: 20),),
      ),
      backgroundColor: ColorManager.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 200,
                  width: 200,
                  child: Image.asset(ImageAssets.splashLogo),
                ),
                Text(
                  AppStrings.welcomeVisitor,
                  style: getBoldStyle(color: Colors.black, fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  AppStrings.welcomeSign,
                  textAlign: TextAlign.center,
                  style: getBoldStyle(color: Colors.grey, fontSize: 18),
                ),
                const SizedBox(
                  height: 25,
                ),
                InkWell(
                  child: Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      elevation: 5,
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Image.asset(ImageAssets.money,width: 35,height: 35,),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              "دفع فاتورة",
                              style: getSemiBoldStyle(
                                  color: ColorManager.darkGray, fontSize: 18),
                            ),
                          ),
                          const Spacer(),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(IconBroken.Arrow___Left_2),
                          ),
                        ],
                      )),
                  onTap: () {
                    navigateTo(context, VisitorPayView());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
