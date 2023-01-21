import 'package:bill_hub/app/modules/vendor/invoice/invoice_cubit/cubit.dart';
import 'package:bill_hub/app/modules/vendor/invoice/invoice_cubit/states.dart';
import 'package:bill_hub/shared/components/component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../styles/icons_broken.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/styles_manager.dart';

class CustomerInformation extends StatelessWidget {
  CustomerInformation({Key? key}) : super(key: key);
  var nameController =TextEditingController();
  var phoneController =TextEditingController();
  var formKay = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InvoiceCubit,InvoiceStates>(
     listener: (context, state) {

     },
      builder: (context, state) {
       var cubit = InvoiceCubit.getCubit(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'معلومات المشتري',
              style: getSemiBoldStyle(color: ColorManager.white, fontSize: 20),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Form(
                key: formKay,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(
                          'تأكد من بيانات عميلك اولا'
                          ,style: getSemiBoldStyle(color: ColorManager.black, fontSize: 18),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    defaultFormField(
                        controller: nameController,
                        label: 'أسم العميل',
                        prefix: Icon(IconBroken.Profile,color: ColorManager.primary,),
                        validate: (value){
                          if(value.isEmpty){
                            return 'من فضلك أدخل أسم العميل';
                          }
                          return null;
                        },
                        type: TextInputType.text,
                        context: context
                    ),
                    SizedBox(height: 10,),
                    defaultFormField(
                        controller: phoneController,
                        label: 'هاتف العميل',
                        prefix: Icon(IconBroken.Profile,color: ColorManager.primary,),
                        validate: (value){
                          if(value.isEmpty){
                            return 'من فضلك أدخل هاتف العميل';
                          }
                          return null;
                        },
                        type: TextInputType.number,
                        context: context
                    ),
                    SizedBox(height: 10,),
                    TextButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(ColorManager.primary),
                          shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))
                      ),
                      onPressed: () {
                        if(formKay.currentState!.validate()){
                          cubit.changeCustomerData(nameController.text, phoneController.text);
                          cubit.change2(true);
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        "حفظ",
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
}
