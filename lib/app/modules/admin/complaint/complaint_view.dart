import 'package:bill_hub/shared/components/component.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/styles_manager.dart';
import 'complaint_details_view.dart';

class ComplaintAdminView extends StatelessWidget {
  const ComplaintAdminView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الشكاوي',style: getSemiBoldStyle(color: ColorManager.white,fontSize: 20),),
      ),
      body: ConditionalBuilder(
        condition: false,
        builder: (context) => ComplaintListView(context),
        fallback: (context) =>
        Center(child: Text('لا توجد شكاوي حاليا',style: getSemiBoldStyle(color: ColorManager.black,fontSize: 16),)
        ),
      ),
    );
  }

  Widget ComplaintListView(context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ComplaintItemBuilder(context);
              },
              separatorBuilder: (context, index) => const SizedBox(
                height: 2,
              ),
              itemCount: 10 // todo list students
          ),
        ],
      ),
    );
  }

  Widget ComplaintItemBuilder(context) {
    return InkWell(
      onTap: () {
        navigateTo(context, ComplaintAdminDetailsView());
        },
      child: Padding(
        padding: const EdgeInsets.only(
          left: 5,
          right: 5,
        ),
        child: Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: 5,
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Image.asset(ImageAssets.complaint,width: 40,height: 40,),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    width: 180,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "محمود محمد علي محمود محمد",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: getSemiBoldStyle(
                              color: ColorManager.darkGray, fontSize: 16),
                        ),
                        Text(
                          "عنوان الشكوي",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: getSemiBoldStyle(
                              color: ColorManager.gray, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  "لم يتم الرد",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: getSemiBoldStyle(
                      color: ColorManager.gray, fontSize: 12),
                ),
                SizedBox(width: 10,),
              ],
            )),
      ),
    );
  }
}
