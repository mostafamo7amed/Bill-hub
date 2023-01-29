import 'package:bill_hub/app/modules/admin/home/home_cubit/cubit.dart';
import 'package:bill_hub/app/modules/admin/home/home_cubit/states.dart';
import 'package:bill_hub/shared/components/component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../styles/icons_broken.dart';
import '../../../model/complaint.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/styles_manager.dart';

class ComplaintAdminDetailsView extends StatelessWidget {
  Complaint complaint;
  int index;
  ComplaintAdminDetailsView(this.complaint,this.index,{Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();
  var replyController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit,AdminStates>(
     listener: (context, state) {
       if(state is UpdateComplaintSuccessState){
         replyController.text = '';
         toast(message: 'تم الرد علي الشكوي', data: ToastStates.success);
         AdminCubit.getCubit(context).GetAllComplaint();
         Navigator.pop(context);
       }

     },
      builder: (context, state) {
       var cubit  = AdminCubit.getCubit(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'تفاصيل الشكوي',
              style: getSemiBoldStyle(color: ColorManager.white, fontSize: 20),
            ),
          ),
          body: Form(
            key: formKey,
            child: Padding(
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
                                      color: ColorManager.gray, fontSize: 14),
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
                                      color: ColorManager.gray, fontSize: 14),
                                ),
                                Text(
                                  "${complaint.description}",
                                  style: getSemiBoldStyle(
                                      color: ColorManager.black, fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: replyController,
                          maxLines: null,
                          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            height: 1.5,
                            fontSize: 17,
                            fontWeight: FontWeight.normal,
                          ),
                          decoration: const InputDecoration(
                            contentPadding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                            hintText: 'رد علي الشكوي',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'من فضلك رد علي الشكوي';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            cubit.replyComplaint(reply: replyController.text, index: index);
                          }
                        },
                        icon: Icon(
                          IconBroken.Send,
                          color: ColorManager.primary,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
