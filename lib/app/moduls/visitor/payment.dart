import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../shared/components/formatters.dart';
import '../../resources/color_manager.dart';
import '../../resources/styles_manager.dart';

class PaymentView extends StatelessWidget {
  PaymentView({Key? key}) : super(key: key);
  TextEditingController holderNameController = TextEditingController();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expiryController = TextEditingController();
  TextEditingController cvvController = TextEditingController();

  bool isLoading = false;
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
                        return '';
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
                        return '';

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
                        return '';
                      },
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: (){},
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