import 'package:bill_hub/app/modules/vendor/invoice/invoice_cubit/cubit.dart';
import 'package:bill_hub/app/modules/vendor/invoice/invoice_cubit/states.dart';
import 'package:bill_hub/app/modules/vendor/product/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return BlocConsumer<InvoiceCubit,InvoiceStates>(
      listener: (context, state) {
        if(state is AddProductSuccessState){
          InvoiceCubit.getCubit(context).GetVendorProducts();
          toast(message: 'تم إضافة المنتج', data: ToastStates.success);
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        var cubit = InvoiceCubit.getCubit(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'إضافة منتج',
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
                          }else if(_isNumeric(value)==false){
                            return 'من فضلك ادخل سعر المنتج الصحيح';
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
                          }else if(_isNumeric(value)==false){
                            return 'من فضلك ادخل الكمية الصحيحة (عدد صحيح)';
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
                        if(formKey.currentState!.validate()){
                          cubit.AddVendorProduct(name: namePrController.text, price: double.parse(pricePrController.text), amount: int.parse(amountPrController.text));
                        }
                      },
                      child: Text(
                        "إضافة",
                        style: getRegularStyle(color: ColorManager.white, fontSize: 16),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  bool _isNumeric(String result) {
    if (result == null) {
      return false;
    }
    return double.tryParse(result) != null;
  }
}
