import 'package:flutter/material.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/styles_manager.dart';

class ComplaintBuyerDetailsView extends StatelessWidget {
  ComplaintBuyerDetailsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'تفاصيل الشكوي',
          style: getSemiBoldStyle(color: ColorManager.white, fontSize: 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "عنوان الشكوي",
                            style: getSemiBoldStyle(
                                color: ColorManager.darkGray, fontSize: 14),
                          ),
                          Text(
                            "شكوي متعلقة بعملية الدفع",
                            style: getSemiBoldStyle(
                                color: ColorManager.black, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "نص الشكوي",
                            style: getSemiBoldStyle(
                                color: ColorManager.darkGray, fontSize: 14),
                          ),
                          Text(
                            "اثناء عملية الدفع ختسايسىيسشاشبشبتشابنشابشىب",
                            style: getSemiBoldStyle(
                                color: ColorManager.black, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "رد المسؤول",
                            style: getSemiBoldStyle(
                                color: ColorManager.darkGray, fontSize: 14),
                          ),
                          Text(
                            "لم يتم الرد",
                            style: getSemiBoldStyle(
                                color: ColorManager.black, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
