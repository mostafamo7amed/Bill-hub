import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../shared/components/component.dart';
import '../../../model/complaint.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/styles_manager.dart';
import '../home/buyer_cubit/cubit.dart';
import '../home/buyer_cubit/states.dart';
import 'complaint_details_view.dart';

class BuyerComplaint extends StatefulWidget {
  BuyerComplaint({Key? key}) : super(key: key);
  @override
  State<BuyerComplaint> createState() => _BuyerComplaintState();
}

class _BuyerComplaintState extends State<BuyerComplaint> {
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var now = new DateTime.now();
  var formatter = new DateFormat('yyyy-MM-dd');

  @override
  void initState() {
    BuyerCubit.getCubit(context).GetBuyerComplaint();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BuyerCubit,BuyerStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        var cubit = BuyerCubit.getCubit(context);
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                'الشكاوي',
                style: getSemiBoldStyle(color: ColorManager.white, fontSize: 20),
              ),
            ),
            body: Column(
              children: [
                const SizedBox(
                  width: double.infinity,
                  child: TabBar(
                    labelColor: Colors.red,
                    isScrollable: true,
                    unselectedLabelColor: Colors.black,
                    indicatorColor: Colors.red,
                    indicatorPadding: EdgeInsets.all(15),
                    physics: BouncingScrollPhysics(),
                    tabs: [
                      Tab(text: "إضافة شكوي"),
                      Tab(text: "متابعة شكوي"),
                    ],
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    child: TabBarView(
                      physics: BouncingScrollPhysics(),
                      children: [
                        addNewComplaint(context),
                        ConditionalBuilder(
                          condition: cubit
                              .allBuyerComplaint
                              .isNotEmpty,
                          builder: (context) => viewComplaint(context),
                          fallback: (context) => Center(
                            child: Text(
                              'لا توجد شكاوي حاليا',
                              style: getSemiBoldStyle(
                                  color: ColorManager.black, fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget addNewComplaint(context) => BlocConsumer<BuyerCubit, BuyerStates>(
        listener: (context, state) {
          if (state is AddComplaintSuccessState) {
            titleController.text = '';
            descriptionController.text = '';
            BuyerCubit.getCubit(context).GetBuyerComplaint();
            toast(message: 'تم إرسال الشكوي', data: ToastStates.success);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    defaultFormField(
                        controller: titleController,
                        label: ' عنوان المشكلة ',
                        validate: (value) {
                          if (value.isEmpty) {
                            return 'من فضلك ادخل عنوان المشكلة ';
                          }
                          return null;
                        },
                        type: TextInputType.text,
                        context: context),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: descriptionController,
                      maxLines: null,
                      style: getRegularStyle(
                          color: ColorManager.black, fontSize: 16),
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                        label: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.0),
                          child: Text(' وصف المشكلة ',
                              style: getRegularStyle(
                                  color: ColorManager.black, fontSize: 16)),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'من فضلك ادخل وصف المشكلة ';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(ColorManager.primary),
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)))),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          BuyerCubit.getCubit(context).AddComplaint(
                              title: titleController.text,
                              description: descriptionController.text,
                              date: formatter.format(now));
                        }
                      },
                      child: ConditionalBuilder(
                        condition: state is! AddComplaintLoadingState,
                        builder: (context) => Text(
                          "إضافة الشكوي",
                          style: getRegularStyle(
                              color: ColorManager.white, fontSize: 16),
                        ),
                        fallback: (context) => const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            backgroundColor: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      );

  Widget viewComplaint(context) => BlocConsumer<BuyerCubit, BuyerStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = BuyerCubit.getCubit(context);
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
                        cubit.allBuyerComplaint[index], context);
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 2,
                  ),
                  itemCount: cubit.allBuyerComplaint.length,
                ),
              ],
            ),
          );
        },
      );

  Widget ComplaintItemBuilder(Complaint complaint, context) {
    return InkWell(
      onTap: () {
        navigateTo(context, ComplaintBuyerDetailsView(complaint));
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
                          "${complaint.title}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: getSemiBoldStyle(
                              color: ColorManager.black, fontSize: 14),
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
                            color: ColorManager.gray, fontSize: 14),
                      )
                    : Text(
                        "لم يتم الرد",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: getSemiBoldStyle(
                            color: ColorManager.gray, fontSize: 14),
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
