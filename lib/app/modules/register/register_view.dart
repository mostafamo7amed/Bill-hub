import 'package:bill_hub/app/modules/register/register_cubit/cubit.dart';
import 'package:bill_hub/app/modules/register/register_cubit/states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/components/component.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/strings_manager.dart';
import '../buyer/create_account/create_account.dart';
import '../vendor/create_account/create_account.dart';

class RegisterView extends StatefulWidget {
  RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var conFirmPasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  List<bool> isSelected = [true, false];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterStates>(
       listener: (context, state) {
         if(state is RegisterSuccessState){
           CacheHelper.saveData(key: 'uid', data: state.id);
           String userType  ='';
           userType = isSelected[0]==true? 'Vendor':'Buyer';
           print('============= user type $userType ================');
             if(isSelected[0]==true){
               navigateTo(context, CreateVendorAccount(emailController.text,passwordController.text,state.id));
             }else{
               navigateTo(context, CreateBuyerAccount(emailController.text,passwordController.text,state.id));
             }

         }
       },
        builder: (context, state) {
         var cubit = RegisterCubit.getCubit(context);
          return Scaffold(
            backgroundColor: ColorManager.white,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 200,
                            width: 200,
                            child: Image.asset(ImageAssets.splashLogo),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          defaultFormField(
                            context: context,
                            label: AppStrings.enterEmail,
                            prefix: Icon(Icons.email, color: ColorManager.primary),
                            controller: emailController,
                            validate: (value) {
                              if (value!.isEmpty|| !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}').hasMatch(value!)) {
                                return 'من فضلك أدخل بريدك الألكتروني';
                              }
                              return null;
                            },
                            type: TextInputType.emailAddress,
                          ),
                          defaultFormField(
                              context: context,
                              controller: passwordController,
                              label: AppStrings.enterPassword,
                              prefix: Icon(Icons.lock, color: ColorManager.primary),
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'من فضلك أدخل كلمة المرور';
                                }
                                return null;
                              },
                              suffix: cubit.isPassword
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off),
                              pressedShow: () {
                                cubit.changePasswordVisibility();
                              },
                              isPassword: cubit.isPassword,
                              type: TextInputType.visiblePassword),
                          defaultFormField(
                              context: context,
                              controller: conFirmPasswordController,
                              label: AppStrings.reEnterPassword,
                              prefix: Icon(Icons.lock, color: ColorManager.primary),
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'من فضلك أدخل كلمة المرور مرة أخري';
                                }else if(passwordController.text!=conFirmPasswordController.text){
                                  return 'كلمة المرور خاطئة';
                                }
                                return null;
                              },
                              suffix: cubit.isPassword2
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off),
                              pressedShow: () {
                                cubit.changePassword2Visibility();
                              },
                              isPassword: cubit.isPassword2,
                              type: TextInputType.visiblePassword),
                          Container(
                            height: 40,
                            decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(7)),
                            child: ToggleButtons(
                                onPressed: (index) {
                                  setState(() {
                                    for (int i = 0; i < isSelected.length; i++) {
                                      if (i == index) {
                                        isSelected[i] = true;
                                      } else {
                                        isSelected[i] = false;
                                      }
                                    }
                                  });
                                },
                                color: Colors.black,
                                fillColor: ColorManager.primary,
                                selectedColor: Colors.white,
                                focusColor: Colors.white,
                                renderBorder: false,
                                borderRadius: BorderRadius.circular(7),
                                isSelected: isSelected,
                                children: const <Widget>[
                                  Padding(
                                    padding:
                                    EdgeInsets.only(left: 8.0, right: 8),
                                    child: Text('بائع',style: TextStyle(fontSize: 14),),
                                  ),
                                  Padding(
                                    padding:
                                    EdgeInsets.only(left: 8.0, right: 8),
                                    child: Text('مشتري',style: TextStyle(fontSize: 14),),
                                  ),
                                ]),
                          ),
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
                                condition: state is !RegisterLoadingState,
                                builder: (context) => const Text(
                                  'أنشاء حساب',
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
                                  cubit.register(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              },
                            ),
                          ),
                        ],
                      ),
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
