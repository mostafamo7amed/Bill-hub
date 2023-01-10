import 'package:bill_hub/app/modules/buyer/home/home_buyer_view.dart';
import 'package:bill_hub/app/resources/strings_manager.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import '../../../../shared/components/component.dart';
import '../../../../styles/icons_broken.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/styles_manager.dart';

class EditBuyerAccount extends StatelessWidget {
  EditBuyerAccount({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
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
                  SizedBox(height: 15,),
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
                        navigateAndFinish(context, HomeBuyerView());
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
