import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../model/vendor.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/styles_manager.dart';
import '../home/home_cubit/cubit.dart';
import '../home/home_cubit/states.dart';

class ManageUsers extends StatelessWidget {
  ManageUsers({Key? key}) : super(key: key);
  var rejectController =TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit,AdminStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('إدارة البائعين',style: getSemiBoldStyle(color: ColorManager.white,fontSize: 20),),
          ),
          body: ConditionalBuilder(
            condition: AdminCubit.getCubit(context)
                .vendorListModel
                .isNotEmpty,
            builder: (context) => UserListView(context),
            fallback: (context) =>
            AdminCubit.getCubit(context)
                .vendorListModel.length==0?
                Center(child: Text('لا توجد طلبات حاليا',style: getSemiBoldStyle(color: ColorManager.black,fontSize: 16),)):
                Center(child: CircularProgressIndicator(
                strokeWidth: 3,
                backgroundColor: ColorManager.primary,
              ),
            ),
          ),
        );
      },
    );
  }
  Widget UserListView(context) {
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
                return UserItemBuilder(context,cubit.vendorListModel[index],index);
              },
              separatorBuilder: (context, index) => const SizedBox(
                height: 2,
              ),
              itemCount: cubit.vendorListModel.length,
          ),
        ],
      ),
    );
  }

  Widget UserItemBuilder(context,Vendor model,index) {
    return InkWell(
      onTap: () => showUserInfoDialog(context,model,index),
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
                  padding: const EdgeInsets.all(15.0),
                  child: SizedBox(
                    width: 140,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${model.name}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: getSemiBoldStyle(
                              color: ColorManager.darkGray, fontSize: 16),
                        ),
                        Text(
                          "${model.companyName}",
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
                TextButton(
                  style: const ButtonStyle(
                      backgroundColor:
                      MaterialStatePropertyAll(Colors.green)),
                  onPressed: () {
                    var cubit  = AdminCubit.getCubit(context);
                    if(model.isBlocked==true){
                      cubit.RejectUser(
                          isBlocked: false,
                          index: index,
                          blockReason: 'تم قبول طلبكم بأستخدام BillHub نتمني لكم تجربة رائعة ');
                      cubit.removeVendor(index);
                    }
                  },
                  child: Text(
                    "قبول",
                    style: getRegularStyle(color: ColorManager.white),
                  ),
                ),
                const SizedBox(width:5,),
                TextButton(
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.red)),
                  onPressed: () {
                    if(model.blockReason=='يتم الان مراجعة بياناتك سوف نعلمك في حال قبولك'){
                      rejectController.text = '';
                      showRejectDialog(context,index);
                    }
                  },
                  child: model.blockReason!='يتم الان مراجعة بياناتك سوف نعلمك في حال قبولك'?
                    Text(
                    "تم الرفض",
                    style: getRegularStyle(color: ColorManager.white),
                  ):Text(
                    "رفض",
                    style: getRegularStyle(color: ColorManager.white),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),

              ],
            )),
      ),
    );
  }

  Future showUserInfoDialog(context,Vendor model,index) => showDialog(
    context: context,
    builder: (context) {
      var cubit  = AdminCubit.getCubit(context);
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "بيانات البائع",
                  style: getBoldStyle(
                      color: ColorManager.black, fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "أسم البائع",
                      style: getSemiBoldStyle(
                          color: ColorManager.gray, fontSize: 14),
                    ),
                    Text(
                      "${model.name}",
                      style: getSemiBoldStyle(
                          color: ColorManager.black, fontSize: 14),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "اسم الشركة",
                      style: getSemiBoldStyle(
                          color: ColorManager.gray, fontSize: 14),
                    ),
                    Text(
                      "${model.companyName}",
                      style: getSemiBoldStyle(
                          color: ColorManager.black, fontSize: 14),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "قطاع الخدمات",
                      style: getSemiBoldStyle(
                          color: ColorManager.gray, fontSize: 14),
                    ),
                    Text(
                      "${model.employment}",
                      style: getSemiBoldStyle(
                          color: ColorManager.black, fontSize: 14),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "نوع الشركة",
                      style: getSemiBoldStyle(
                          color: ColorManager.gray, fontSize: 14),
                    ),
                    Text(
                      "${model.companyType}",
                      style: getSemiBoldStyle(
                          color: ColorManager.black, fontSize: 14),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "هاتف الشركة",
                      style: getSemiBoldStyle(
                          color: ColorManager.gray, fontSize: 14),
                    ),
                    Text(
                      "${model.phone}",
                      style: getSemiBoldStyle(
                          color: ColorManager.black, fontSize: 14),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "البريد الإلكتروني للشركة",
                      style: getSemiBoldStyle(
                          color: ColorManager.gray, fontSize: 14),
                    ),
                    Text(
                      "${model.email}",
                      style: getSemiBoldStyle(
                          color: ColorManager.black, fontSize: 14),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      style: const ButtonStyle(
                          backgroundColor:
                          MaterialStatePropertyAll(Colors.green)),
                      onPressed: () {
                        if(model.isBlocked==true){
                          cubit.RejectUser(
                              isBlocked: false,
                              index: index,
                              blockReason: 'تم قبول طلبكم بأستخدام BillHub نتمني لكم تجربة رائعة ');
                          cubit.removeVendor(index);
                        }
                      },
                      child: Text(
                        "قبول",
                        style: getRegularStyle(color: ColorManager.white),
                      ),
                    ),
                    const SizedBox(width:15,),
                    TextButton(
                      style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(Colors.red)),
                      onPressed: () {
                        if(model.blockReason =='يتم الان مراجعة بياناتك سوف نعلمك في حال قبولك'){
                          rejectController.text = '';
                          Navigator.pop(context);
                          showRejectDialog(context,index);
                        }
                      },
                      child: model.blockReason!='يتم الان مراجعة بياناتك سوف نعلمك في حال قبولك'?
                      Text(
                        "تم الرفض",
                        style: getRegularStyle(color: ColorManager.white),
                      ):Text(
                        "رفض",
                        style: getRegularStyle(color: ColorManager.white),
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

  Future showRejectDialog(context,index) => showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "سبب رفض البائع",
                    style: getBoldStyle(
                        color: ColorManager.black, fontSize: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller:rejectController,
                          maxLines: null,
                          style: getRegularStyle(color: ColorManager.black,fontSize: 16),
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 5),
                            hintText: 'اكتب شئ ...',
                            border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10.0)),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'أخبر البائع سبب الرفض';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.text,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        style: const ButtonStyle(
                            backgroundColor:
                            MaterialStatePropertyAll(Colors.green)),
                        onPressed: () {
                          var cubit = AdminCubit.getCubit(context);
                          if(formKey.currentState!.validate()){
                            cubit.RejectUser(isBlocked: true, index: index, blockReason: rejectController.text);
                            rejectController.text ='';
                            Navigator.pop(context);
                          }
                        },
                        child: Text(
                          "أرسال",
                          style: getRegularStyle(color: ColorManager.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
