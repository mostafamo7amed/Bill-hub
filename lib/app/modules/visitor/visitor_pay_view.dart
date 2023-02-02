import 'package:bill_hub/app/model/invoice_item.dart';
import 'package:bill_hub/app/modules/vendor/invoice/view_invoice_pdf.dart';
import 'package:bill_hub/app/modules/visitor/payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/components/component.dart';
import '../../../styles/icons_broken.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/styles_manager.dart';
import '../vendor/invoice/invoice_cubit/cubit.dart';
import '../vendor/invoice/invoice_cubit/states.dart';

class VisitorPayView extends StatelessWidget {
  VisitorPayView({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  var billController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InvoiceCubit,InvoiceStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        var cubit = InvoiceCubit.getCubit(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('دفع فاتورة',style: getSemiBoldStyle(color: ColorManager.white,fontSize: 20),),
          ),
          backgroundColor: ColorManager.white,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: Image.asset(ImageAssets.splashLogo),
                      ),
                      defaultFormField(
                        context: context,
                        label: AppStrings.enterBillNumber,
                        prefix: Icon(IconBroken.Document,color: ColorManager.primary),
                        controller: billController,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'من فضلك أدخل رقم الفاتورة';
                          }
                          return null;
                        },
                        type: TextInputType.phone,
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            style: ButtonStyle(
                                backgroundColor:
                                MaterialStatePropertyAll(ColorManager.primary)),
                            onPressed: () {
                              if(formKey.currentState!.validate()){
                                InvoiceItem? value = cubit.search(billController.text);
                                if(value!=null){
                                  navigateTo(context, ViewInvoicePdf(value.fileUrl!,true,'visitor',0,value));
                                }else{
                                  toast(message: 'لا توجد فاتورة بهذا الرقم', data: ToastStates.warning);
                                }
                              }
                            },
                            child: Text(
                              "عرض الفاتورة",
                              style: getRegularStyle(color: ColorManager.white,fontSize: 16),
                            ),
                          ),
                        ],),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
