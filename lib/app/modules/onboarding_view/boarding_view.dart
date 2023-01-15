import 'package:bill_hub/app/modules/login/login_view.dart';
import 'package:bill_hub/app/resources/assets_manager.dart';
import 'package:bill_hub/app/resources/color_manager.dart';
import 'package:bill_hub/app/resources/strings_manager.dart';
import 'package:bill_hub/app/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../shared/components/component.dart';
import '../../../shared/network/local/cache_helper.dart';

class OnBoardingModel {
  final String image;
  final String title;

  OnBoardingModel({
    required this.image,
    required this.title,
  });
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  bool isLast = false;
  var boardingController = PageController();
  List<OnBoardingModel> boarding = [
    OnBoardingModel(
      image: ImageAssets.splashLogo,
      title: AppStrings.onBoardingTitle1,
    ),
    OnBoardingModel(
      image: ImageAssets.splashLogo,
      title: AppStrings.onBoardingTitle2,
    ),
    OnBoardingModel(
      image: ImageAssets.splashLogo,
      title: AppStrings.onBoardingTitle3,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        actions: [
          TextButton(
              onPressed: () {
                submit();
              },
              child: Text(
                AppStrings.skip,
                style:
                    getSemiBoldStyle(color: ColorManager.primary, fontSize: 16),
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                controller: boardingController,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    defaultOnBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                    effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      expansionFactor: 4.0,
                      dotHeight: 10,
                      dotWidth: 10,
                      spacing: 5.0,
                      activeDotColor: ColorManager.primary,
                    ),
                    controller: boardingController,
                    count: boarding.length),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      boardingController.nextPage(
                          duration: const Duration(
                            milliseconds: 750,
                          ),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child: const Icon(Icons.arrow_forward_ios),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget defaultOnBoardingItem(OnBoardingModel list) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
              child: Text(
            'BillHub',
            textAlign: TextAlign.center,
            style: getBoldStyle(color: ColorManager.primary, fontSize: 26),
          )),
          Expanded(
            child: Image(
              image: AssetImage(list.image),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            list.title,
            style: getSemiBoldStyle(color: ColorManager.darkGray, fontSize: 18),
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      );

  void submit() {
    CacheHelper.saveData(key: 'onBoarding', data: true).then((value){
      navigateAndFinish(context, LoginView());
    });
  }
}
