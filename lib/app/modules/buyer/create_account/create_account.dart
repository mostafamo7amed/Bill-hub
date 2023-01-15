import 'package:bill_hub/app/modules/buyer/home/home_buyer_view.dart';
import 'package:bill_hub/app/resources/strings_manager.dart';
import 'package:bill_hub/shared/network/local/cache_helper.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../shared/components/component.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/styles_manager.dart';
import 'Buyer_registration_cubit/cubit.dart';
import 'Buyer_registration_cubit/states.dart';

class CreateBuyerAccount extends StatelessWidget {
  String password, email, id;
  CreateBuyerAccount(this.email, this.password, this.id, {Key? key})
      : super(key: key);
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterBuyerCubit(),
      child: BlocConsumer<RegisterBuyerCubit, RegisterBuyerStates>(
        listener: (context, state) {
          if(state is CreateBuyerSuccessState){
            CacheHelper.saveData(key: 'uid', data: state.id);
            navigateAndFinish(context, HomeBuyerView());
          }
        },
        builder: (context, state) {
          var cubit = RegisterBuyerCubit.getCubit(context);
          return Scaffold(
            backgroundColor: ColorManager.white,
            body: SafeArea(
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 200,
                          width: 200,
                          child: Image.asset(ImageAssets.splashLogo),
                        ),
                        Text(
                          'أنشاء حساب مشتري',
                          style:
                              getBoldStyle(color: Colors.black, fontSize: 20),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        defaultFormField(
                            controller: nameController,
                            label: AppStrings.enterName,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'من فضلك أدخل الاسم';
                              }
                              return null;
                            },
                            type: TextInputType.text,
                            context: context),
                        defaultFormField(
                            context: context,
                            controller: phoneController,
                            label: AppStrings.enterPhone,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'من فضلك أدخل رقم الهاتف';
                              }
                              return null;
                            },
                            type: TextInputType.number),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: double.infinity,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: ColorManager.primary,
                          ),
                          child: MaterialButton(
                            child: ConditionalBuilder(
                              condition: state is! CreateBuyerLoadingState,
                              builder: (context) => const Text(
                                'حفظ البيانات',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              fallback: (context) => const SizedBox(
                                height: 25,
                                width: 25,
                                child: CircularProgressIndicator(
                                  strokeWidth: 3,
                                  backgroundColor: Colors.white,
                                ),
                              ),
                            ),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                cubit.createBuyerAccount(
                                    userType: 'Buyer',
                                    email: email,
                                    name: nameController.text,
                                    phone: phoneController.text,
                                    id: id);
                              }
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'بأستكمال عملية التسجيل انت توافق علي سياسة التطبيق',
                          style: getSemiBoldStyle(
                              color: Colors.grey, fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
