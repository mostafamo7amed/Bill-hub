import 'package:flutter/material.dart';

import '../../../../styles/icons_broken.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/styles_manager.dart';

class ComplaintAdminDetailsView extends StatelessWidget {
  ComplaintAdminDetailsView({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();
  var replyController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'تفاصيل الشكوي',
          style: getSemiBoldStyle(color: ColorManager.white, fontSize: 20),
        ),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "عنوان الشكوي",
                              style: getSemiBoldStyle(
                                  color: ColorManager.gray, fontSize: 14),
                            ),
                            Text(
                              "شكوي متعلقة بعملية الدفع",
                              style: getSemiBoldStyle(
                                  color: ColorManager.black, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "نص الشكوي",
                              style: getSemiBoldStyle(
                                  color: ColorManager.gray, fontSize: 14),
                            ),
                            Text(
                              "اثناء عملية الدفع ختسايسىيسشاشبشبتشابنشابشىب",
                              style: getSemiBoldStyle(
                                  color: ColorManager.black, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: replyController,
                      maxLines: null,
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            height: 1.5,
                            fontSize: 17,
                            fontWeight: FontWeight.normal,
                          ),
                      decoration: const InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                        hintText: 'رد علي الشكوي',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'من فضلك رد علي الشكوي';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {}
                    },
                    icon: Icon(
                      IconBroken.Send,
                      color: ColorManager.primary,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
