import 'package:bill_hub/app/modules/admin/home/home_admin.dart';
import 'package:bill_hub/app/resources/strings_manager.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../../resources/assets_manager.dart';
import '../../../shared/components/component.dart';
import '../../resources/color_manager.dart';
import '../../resources/styles_manager.dart';
import '../forget_password/forget_password.dart';
import '../register/register_view.dart';
import '../visitor/visitor_view.dart';
import 'login_cubit/cubit.dart';
import 'login_cubit/states.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginStates>(
        listener: (context, state) {
          if(state is LoginSuccessState){
            CacheHelper.saveData(key: 'uid', data: state.uid);
            print('state id == ${state.uid}');
            LoginCubit.getCubit(context).findUser(state.uid, context);
          }
        },
        builder: (context, state) {
          var cubit =LoginCubit.getCubit(context);
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
                          Text(
                            AppStrings.welcome,
                            style: getBoldStyle(color: Colors.black, fontSize: 20),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          defaultFormField(
                            context: context,
                            label: AppStrings.enterEmail,
                            prefix: Icon(Icons.email,color: ColorManager.primary),
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                style: const ButtonStyle(minimumSize:MaterialStatePropertyAll(Size.zero)),
                                onPressed: () {
                                  navigateTo(context, ForgetPasswordView());
                                },
                                child: Text(
                                  AppStrings.forgetPassword,
                                  style: getSemiBoldStyle(color: ColorManager.darkGray),
                                ),
                              ),
                            ],
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
                                condition: state is !LoginLoadingState, //TODO loading state
                                builder: (context) => Text(
                                  AppStrings.signIn,
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
                                if(formKey.currentState!.validate()){
                                  cubit.userLogin(email: emailController.text, password: passwordController.text,context: context);
                                }
                              },
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'ليس لديك حساب؟',
                                style: getSemiBoldStyle(color: ColorManager.black),
                              ),
                              TextButton(
                                onPressed: () {
                                  navigateTo(context, RegisterView());
                                },
                                child: Text(
                                  AppStrings.createAccount,
                                  style: getSemiBoldStyle(color: ColorManager.primary),
                                ),
                              ),
                              Text(
                                'أو',
                                style: getSemiBoldStyle(color: ColorManager.black),
                              ),
                              TextButton(
                                onPressed: () {
                                  navigateTo(context, VisitorView());
                                },
                                child: Text(
                                  AppStrings.signVisitor,
                                  style: getSemiBoldStyle(color: ColorManager.primary),
                                ),
                              ),
                            ],
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
