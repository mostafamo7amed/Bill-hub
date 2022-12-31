import 'package:bill_hub/app/modules/vendor/invoice/invoice_cubit/cubit.dart';
import 'package:bill_hub/app/modules/vendor/invoice/invoice_cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../resources/color_manager.dart';
import '../../../resources/styles_manager.dart';

class GeneralInformation extends StatelessWidget {
  int invoiceNum;
  GeneralInformation(this.invoiceNum,{Key? key}) : super(key: key);
  var formatter = new DateFormat('yyyy-MM-dd');
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
              'معلومات الفاتورة',
              style: getSemiBoldStyle(color: ColorManager.white, fontSize: 20),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "معرف الفاتورة ",
                                style: getSemiBoldStyle(
                                    color: ColorManager.black, fontSize: 16),
                              ),
                              Text(
                                "${invoiceNum}",
                                style: getSemiBoldStyle(
                                    color: ColorManager.black, fontSize: 16),
                              ),
                            ],
                          ),
                          SizedBox(height: 5,),
                          Container(
                            width: double.infinity,
                            height: 0.6,
                            child: Container(color: ColorManager.black,),
                          ),
                          SizedBox(height: 5,),
                          Row(
                            children: [
                              Text(
                                "تاريخ الصلاحية: ",
                                style: getSemiBoldStyle(
                                    color: ColorManager.black, fontSize: 16),
                              ),
                              IconButton(onPressed: (){
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.parse('2050-11-11'),
                                  builder: (context, child) {
                                    return Theme(
                                      data: ThemeData.dark().copyWith(
                                        colorScheme: ColorScheme.dark(
                                          primary: Colors.grey,
                                          onPrimary: Colors.black,
                                          surface: ColorManager.primary,
                                          onSurface: ColorManager.lightPrimary,
                                        ),
                                        dialogBackgroundColor:Colors.white,
                                      ),
                                      child: child!,
                                    );
                                  },
                                ).then((value) {
                                  if(value != null) {
                                    cubit.changeExpDate(formatter.format(value).toString());
                                  }else {
                                    cubit.changeExpDate('');
                                  }
                                });
                              }, icon: Icon(Icons.calendar_month_outlined)),
                              Expanded(
                                child: Text(
                                  "${cubit.expDate}",
                                  style: getSemiBoldStyle(
                                      color: ColorManager.black, fontSize: 16),
                                ),
                              ),

                            ],
                          ),
                          SizedBox(height: 5,),
                          TextButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(ColorManager.primary),
                                shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))
                            ),
                            onPressed: () {
                              if(cubit.expDate != ''){
                                cubit.change1();
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
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
