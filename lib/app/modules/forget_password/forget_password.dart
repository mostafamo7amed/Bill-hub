import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../shared/components/component.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/styles_manager.dart';

class ForgetPasswordView extends StatelessWidget {
  ForgetPasswordView({Key? key}) : super(key: key);
  var emailController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('إستعادة كلمة المرور'),
      ),
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
                      height: 150,
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
                          builder: (context) => Text('أرسال',
                              style: getRegularStyle(
                                  color: ColorManager.white, fontSize: 16)),
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
                            FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text).then((value) {
                              toast(message: 'تفقد بريدك الوارد لأستعادة كلمة المرور', data: ToastStates.success);
                            }).catchError((e){
                              toast(message: e.toString(), data: ToastStates.warning);
                            });
                          }
                        },
                      ),
                    ),
                    // support messages
                    /*SizedBox(
                      height: 150,
                      width: 200,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            elevation: 1,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: ImageIcon(
                                      const AssetImage(ImageAssets.message),
                                    color: ColorManager.error,
                                    size: 30,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("We Ready to help",
                                  style: getSemiBoldStyle(color: ColorManager.darkGray,fontSize: 14),
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ),*/
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
