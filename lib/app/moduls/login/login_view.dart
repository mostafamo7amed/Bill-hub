import 'package:bill_hub/app/moduls/admin/home/home_admin.dart';
import 'package:bill_hub/app/resources/strings_manager.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import '../../resources/assets_manager.dart';
import '../../../shared/components/component.dart';
import '../../resources/color_manager.dart';
import '../../resources/styles_manager.dart';
import '../visitor/visitor_view.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: SingleChildScrollView(
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
                        if (value!.isEmpty) {
                          return 'من فضلك أدخل بريدك الألكتروني';
                        }
                        return null;
                      },
                      type: TextInputType.emailAddress,
                    ),
                    const SizedBox(
                      height: 10.0,
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
                        suffix: true
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off),
                        pressedShow: () {
                          // TODO change visibility
                        },
                        isPassword: true,
                        type: TextInputType.visiblePassword),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          style: const ButtonStyle(minimumSize:MaterialStatePropertyAll(Size.zero)),
                          onPressed: () {
                            //navigateTo(context, ForgetPasswordView());
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
                          condition: true, //TODO loading state
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
                          //TODO login press
                          navigateAndFinish(context, AdminHomeView());
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
                            //navigateTo(context, RegisterView());
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
  }
}
