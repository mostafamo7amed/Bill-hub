import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import '../../../shared/components/component.dart';
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
                        if (value!.isEmpty) {
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
                        suffix: true
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off),
                        pressedShow: () {
                          // TODO change visibility
                        },
                        isPassword: true,
                        type: TextInputType.visiblePassword),
                    defaultFormField(
                        context: context,
                        controller: conFirmPasswordController,
                        label: AppStrings.reEnterPassword,
                        prefix: Icon(Icons.lock, color: ColorManager.primary),
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'من فضلك أدخل كلمة المرور مرة أخري';
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
                          condition: true, //TODO loading state
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
                          if(formKey.currentState!.validate()){
                            if(isSelected[0]==true){
                              navigateTo(context, CreateVendorAccount(emailController.text,passwordController.text));
                            }else{
                              navigateTo(context, CreateBuyerAccount(emailController.text,passwordController.text));
                            }
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
  }
}
