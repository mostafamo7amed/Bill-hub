import 'package:bill_hub/app/modules/vendor/home/home_vendor_view.dart';
import 'package:bill_hub/app/resources/strings_manager.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import '../../../../shared/components/component.dart';
import '../../../../styles/icons_broken.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/styles_manager.dart';
import '../../../resources/value_manager.dart';
import '../create_account/vendor_registration_cubit/cubit.dart';
import '../create_account/vendor_registration_cubit/states.dart';

class EditVendorAccount extends StatelessWidget {
  EditVendorAccount({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var compController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterVendorCubit(),
      child: BlocConsumer<RegisterVendorCubit, RegisterVendorStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = RegisterVendorCubit.getCubit(context);
          return Scaffold(
            appBar: AppBar(title: Text(
              'المعلومات الشخصية',
              style: getSemiBoldStyle(color: ColorManager.white, fontSize: 20),
            ),),
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
                          height: 120,
                          child: Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  width: 117,
                                  child: Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: [
                                      CircleAvatar(
                                        radius: 50,
                                        backgroundColor:ColorManager.primary,
                                        child: const CircleAvatar(
                                          radius: 48,
                                          backgroundImage: AssetImage(
                                            ImageAssets.photo,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Align(
                                          alignment: Alignment.bottomRight,
                                          child: CircleAvatar(
                                            radius: 16,
                                            child: Icon(
                                              IconBroken.Camera,
                                              color: ColorManager.white,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
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
                            pressedShow: () {
                              // TODO change visibility
                            },
                            isPassword: true,
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
                            pressedShow: () {
                              // TODO change visibility
                            },
                            isPassword: true,
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
                              condition: true, //TODO loading state
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
                              //TODO create press
                              navigateAndFinish(context, HomeVendorView());
                            },
                          ),
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
