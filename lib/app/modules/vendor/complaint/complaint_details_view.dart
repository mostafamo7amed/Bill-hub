import 'package:flutter/material.dart';
import '../../../model/complaint.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/styles_manager.dart';

class ComplaintVendorDetailsView extends StatelessWidget {
  Complaint complaint;
  ComplaintVendorDetailsView(this.complaint,{Key? key}) : super(key: key);
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
        child: Container(
          width: double.infinity,
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
                              "${complaint.title}",
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
                              "${complaint.description}",
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
                            complaint.status!
                                ? Text(
                              "${complaint.reply}",
                              maxLines: null,
                              style: getSemiBoldStyle(
                                  color: ColorManager.black, fontSize: 16),
                            )
                                : Text(
                              "لم يتم الرد بعد",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: getSemiBoldStyle(
                                  color: ColorManager.gray, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
