import 'package:bill_hub/app/modules/buyer/home/buyer_cubit/cubit.dart';
import 'package:bill_hub/app/modules/vendor/invoice/invoice_cubit/cubit.dart';
import 'package:bill_hub/app/modules/visitor/visitor_pay_view.dart';
import 'package:bill_hub/shared/components/component.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../shared/components/formatters.dart';
import '../../model/invoice_item.dart';
import '../../resources/color_manager.dart';
import '../../resources/styles_manager.dart';
import '../buyer/invoice/invoice_buyer_view.dart';

class PaymentView extends StatelessWidget {
  String userType;
  int index;
  InvoiceItem invoiceItem;
  PaymentView(this.userType,this.index,this.invoiceItem,{Key? key}) : super(key: key);
  TextEditingController holderNameController = TextEditingController();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expiryController = TextEditingController();
  TextEditingController cvvController = TextEditingController();

  bool isLoading = false;
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("دفع فاتورة"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: Builder(
              builder: (context) {
                return Column(
                  children: [
                    const SizedBox(height: 10),
                    // Holder
                    TextFormField(
                      controller: holderNameController,
                      decoration: _inputDecoration(
                        label: "أسم حامل البطاق",
                        hint: "أسم حامل البطاق",
                        icon: Icons.account_circle_rounded,
                      ),
                      validator: (value) {
                        if(value!.isEmpty){
                          return '';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    // Number
                    TextFormField(
                      controller: cardNumberController,
                      decoration: _inputDecoration(
                        label: "رقم البطاقة",
                        hint: "0000 0000 0000 0000",
                        icon: Icons.credit_card,
                      ),
                      onChanged: (value) {
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(14),
                        CardNumberInputFormatter()
                      ],
                      validator: (String? number) {
                        if(number!.isEmpty){
                          return '';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    // Expiry date
                    TextFormField(
                      controller: expiryController,
                      decoration: _inputDecoration(
                        label: "تاريخ الانتهاء",
                        hint: "MM/YY",
                        icon: Icons.date_range_rounded,
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(4),
                        CardMonthInputFormatter(),
                      ],
                      validator: (String? date) {
                        if(date!.isEmpty){
                          return '';
                        }
                        return null;

                      },
                    ),
                    const SizedBox(height: 10),
                    // CVV
                    TextFormField(
                      controller: cvvController,
                      decoration: _inputDecoration(
                        label: "CVV",
                        hint: "000",
                        icon: Icons.confirmation_number_rounded,
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(4),
                      ],
                      validator: (String? cvv) {
                        if(cvv!.isEmpty){
                          return '';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: (){
                          if(formKey.currentState!.validate()){
                            if(userType=='buyer'){
                              print('====================$userType');
                              BuyerCubit.getCubit(context).payInvoice(index: index);
                              toast(message: 'تم دفع الفاتورة', data: ToastStates.success);
                              navigateAndFinish(context, InvoiceBuyerView());
                            }else{
                              InvoiceCubit.getCubit(context).payInvoice(Item: invoiceItem);
                              toast(message: 'تم دفع الفاتورة', data: ToastStates.success);
                              navigateAndFinish(context, VisitorPayView());
                            }

                          }
                        },
                        child: Text(
                          isLoading
                              ? 'Processing your request, please wait...'
                              : 'دفع',
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}


InputDecoration _inputDecoration(
    {String? label, String? hint, dynamic icon}) {
  return InputDecoration(
    hintText: hint,
    labelText: label,
    labelStyle: getRegularStyle(color: ColorManager.black, fontSize: 16),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
    prefixIcon: icon is IconData
        ? Icon(icon,color: ColorManager.primary,)
        : Container(
      padding: const EdgeInsets.all(6),
      width: 10,
      child: Image.asset(icon,color: ColorManager.primary,),
    ),
  );
}