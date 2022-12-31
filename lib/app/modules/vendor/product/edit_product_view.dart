import 'package:flutter/material.dart';

import '../../../../shared/components/component.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/styles_manager.dart';

class AddProductView extends StatelessWidget {
  AddProductView({Key? key}) : super(key: key);

  var namePrController = TextEditingController();
  var pricePrController = TextEditingController();
  var amountPrController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'تعديل المنتج',
          style: getSemiBoldStyle(color: ColorManager.white, fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                defaultFormField(
                    controller: namePrController,
                    label: ' أسم المنتج ',
                    validate: (value) {
                      if(value.isEmpty){
                        return 'من فضلك ادخل اسم المنتج ';
                      }
                      return null;
                    },
                    type: TextInputType.text,
                    context: context),
                SizedBox(height: 10,),
                defaultFormField(
                    controller: pricePrController,
                    label: ' سعر المنتج ',
                    validate: (value) {
                      if(value.isEmpty){
                        return 'من فضلك ادخل سعر المنتج ';
                      }
                      return null;
                    },
                    type: TextInputType.number,
                    context: context),
                SizedBox(height: 10,),
                defaultFormField(
                    controller: amountPrController,
                    label: ' الكمية المتاحة ',
                    validate: (value) {
                      if(value.isEmpty){
                        return 'من فضلك ادخل سعر الكمية المتاحة من المنتج ';
                      }
                      return null;
                    },
                    type: TextInputType.number,
                    context: context),
                SizedBox(height: 10,),
                TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(ColorManager.primary),
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))
                  ),
                  onPressed: () {
                    //ToDo view user
                  },
                  child: Text(
                    "تعديل",
                    style: getRegularStyle(color: ColorManager.white, fontSize: 16),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
