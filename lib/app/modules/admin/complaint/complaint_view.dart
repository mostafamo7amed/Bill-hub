import 'package:bill_hub/app/model/complaint.dart';
import 'package:bill_hub/app/modules/admin/home/home_cubit/cubit.dart';
import 'package:bill_hub/app/modules/admin/home/home_cubit/states.dart';
import 'package:bill_hub/shared/components/component.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/styles_manager.dart';
import 'complaint_details_view.dart';

class ComplaintAdminView extends StatelessWidget {
  const ComplaintAdminView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AdminCubit.getCubit(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'الشكاوي',
              style: getSemiBoldStyle(color: ColorManager.white, fontSize: 20),
            ),
          ),
          body: ConditionalBuilder(
            condition: cubit.allComplaint.isNotEmpty,
            builder: (context) => ComplaintListView(context),
            fallback: (context) => Center(
                child: Text(
              'لا توجد شكاوي حاليا',
              style: getSemiBoldStyle(color: ColorManager.black, fontSize: 16),
            )),
          ),
        );
      },
    );
  }

  Widget ComplaintListView(context) {
    var cubit = AdminCubit.getCubit(context);

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return ComplaintItemBuilder(
                  cubit.allComplaint[index], context, index);
            },
            separatorBuilder: (context, index) => const SizedBox(
              height: 2,
            ),
            itemCount: cubit.allComplaint.length,
          ),
        ],
      ),
    );
  }

  Widget ComplaintItemBuilder(Complaint complaint, context, index) {
    return InkWell(
      onTap: () {
        if (complaint.status == false) {
          navigateTo(context, ComplaintAdminDetailsView(complaint, index));
        }
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
                  child: Image.asset(
                    ImageAssets.complaint,
                    width: 40,
                    height: 40,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    width: 180,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${complaint.userName}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: getSemiBoldStyle(
                              color: ColorManager.darkGray, fontSize: 16),
                        ),
                        Text(
                          "${complaint.title}",
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
                complaint.status!
                    ? Text(
                        "تم الرد",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: getSemiBoldStyle(
                            color: ColorManager.gray, fontSize: 12),
                      )
                    : Text(
                        "لم يتم الرد",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: getSemiBoldStyle(
                            color: ColorManager.gray, fontSize: 12),
                      ),
                SizedBox(
                  width: 10,
                ),
              ],
            )),
      ),
    );
  }
}
