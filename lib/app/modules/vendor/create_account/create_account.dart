import 'package:bill_hub/app/modules/vendor/create_account/vendor_registration_cubit/cubit.dart';
import 'package:bill_hub/app/modules/vendor/create_account/vendor_registration_cubit/states.dart';
import 'package:bill_hub/app/modules/vendor/home/home_vendor_view.dart';
import 'package:bill_hub/app/modules/vendor/invoice/invoice_cubit/cubit.dart';
import 'package:bill_hub/app/resources/strings_manager.dart';
import 'package:bill_hub/shared/network/local/cache_helper.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import '../../../../shared/components/component.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/styles_manager.dart';
import '../../../resources/value_manager.dart';

class CreateVendorAccount extends StatelessWidget {
  String password, email,id;
  CreateVendorAccount(this.email, this.password,this.id, {Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var compController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterVendorCubit(),
      child: BlocConsumer<RegisterVendorCubit, RegisterVendorStates>(
        listener: (context, state) {
          if(state is CreateVendorSuccessState){
            CacheHelper.saveData(key: 'uid', data: state.id);
            InvoiceCubit.getCubit(context).setNewUserSales(userId: state.id);
            navigateAndFinish(context, HomeVendorView());
          }
        },
        builder: (context, state) {
          var cubit = RegisterVendorCubit.getCubit(context);
          return Scaffold(
            backgroundColor: ColorManager.white,
            body: SafeArea(
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
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
                          'أنشاء حساب بائع',
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
                        defaultFormField(
                            context: context,
                            controller: compController,
                            label: 'أسم الشركة',
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'من فضلك أدخل أسم الشركة';
                              }
                              return null;
                            },
                            type: TextInputType.text),
                        Container(
                          height: 45,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: ColorManager.gray,
                                  width: AppSize.s1_5)),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 3,
                              ),
                              Text(
                                " قطاع الخدمات ",
                                style: getRegularStyle(
                                    color: ColorManager.black, fontSize: 16),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: FormHelper.dropDownWidget(
                                    context,
                                    'أختر الخدمة',
                                    cubit.services,
                                    cubit.servicesItems,
                                        (value) {
                                  cubit.changeDropDown(value);
                                  cubit.changeCompanyType(value);
                                }, (value) {
                                  if (value.isEmpty) {
                                    return 'من فضلك اختر قطاع الخدمات';
                                  }
                                  return null;
                                },
                                    borderWidth: 0,
                                    borderRadius: 0,
                                    enabledBorderWidth: 0,
                                    focusedBorderWidth: 0,
                                    contentPadding: 0,
                                    paddingLeft: 2.5,
                                    paddingRight: 2.5,
                                    borderColor: ColorManager.white,
                                    borderFocusColor: ColorManager.white),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 45,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: ColorManager.gray,
                                  width: AppSize.s1_5)),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 3,
                              ),
                              Text(
                                " نوع الشركة ",
                                style: getRegularStyle(
                                    color: ColorManager.black, fontSize: 16),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: FormHelper.dropDownWidget(
                                    context,
                                    'أختر الشركة',
                                    cubit.companyType,
                                    cubit.states, (value) {
                                  cubit.changeCompanyDropDown(value);
                                }, (value) {
                                  if (value.isEmpty) {
                                    return 'من فضلك اختر نوع الشركة';
                                  }
                                  return null;
                                },
                                    borderWidth: 0,
                                    borderRadius: 0,
                                    enabledBorderWidth: 0,
                                    focusedBorderWidth: 0,
                                    contentPadding: 0,
                                    paddingLeft: 2.5,
                                    paddingRight: 2.5,
                                    borderColor: ColorManager.white,
                                    borderFocusColor: ColorManager.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
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
                              condition: state is !CreateVendorLoadingState,
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
                              if(formKey.currentState!.validate()&&cubit.services!=null&&cubit.companyType!=null){
                                int index= int.parse(cubit.services!);
                                int index2= int.parse(cubit.companyType!);
                                cubit.createVendorAccount(
                                    userType: 'Vendor',
                                    email: email,
                                    name: nameController.text,
                                    phone: phoneController.text,
                                    id: id,
                                    companyName: compController.text,
                                    companyType: cubit.states[index2]['name'],
                                    employment: cubit.servicesItems[index]['name'],
                                    blockReason: 'يتم الان مراجعة بياناتك سوف نعلمك في حال قبولك',
                                    isBlocked: true);
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'بأستكمال عملية التسجيل انت توافق علي سياسة التطبيق',
                          style:
                          getSemiBoldStyle(color: Colors.grey, fontSize: 11),
                        ),
                        SizedBox(
                          height: 10,
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
