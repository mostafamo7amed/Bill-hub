import 'dart:math';

import 'package:bill_hub/app/modules/vendor/invoice/invoice_cubit/cubit.dart';
import 'package:bill_hub/app/modules/vendor/invoice/invoice_cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../shared/components/component.dart';
import '../../../../styles/icons_broken.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/styles_manager.dart';
import 'customer_information.dart';
import 'customer_products.dart';
import 'general_information.dart';

class NewInvoiceView extends StatelessWidget {
  NewInvoiceView({Key? key}) : super(key: key);
  Random random = new Random();
  var now = new DateTime.now();
  var formatter = new DateFormat('yyyy-MM-dd');

  @override
  Widget build(BuildContext context) {
    int invoiceNumber = random.nextInt(1000000000);
    return BlocConsumer<InvoiceCubit, InvoiceStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = InvoiceCubit.getCubit(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'إنشاء فاتورة',
              style: getSemiBoldStyle(color: ColorManager.white, fontSize: 20),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
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
                                "رقم الفاتورة ",
                                style: getSemiBoldStyle(
                                    color: ColorManager.black, fontSize: 16),
                              ),
                              Text(
                                "${invoiceNumber}",
                                style: getSemiBoldStyle(
                                    color: ColorManager.black, fontSize: 16),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "تاريخ الانشاء ",
                                style: getSemiBoldStyle(
                                    color: ColorManager.gray, fontSize: 16),
                              ),
                              Text(
                                "${formatter.format(now)}",
                                style: getSemiBoldStyle(
                                    color: ColorManager.gray, fontSize: 16),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    child: Card(
                        margin: const EdgeInsets.all(5),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: 3,
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                IconBroken.Document,
                                size: 32,
                                color: ColorManager.primary,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                IconBroken.Arrow___Left_2,
                                color: ColorManager.primary,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "معلومات عامة",
                                    style: getSemiBoldStyle(
                                        color: ColorManager.black,
                                        fontSize: 18),
                                  ),
                                  Text(
                                    "أضف بيانات عامة للفاتورة",
                                    style: getSemiBoldStyle(
                                        color: ColorManager.gray, fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            if (cubit.invoice1)
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.check_circle_outline,
                                  size: 25,
                                  color: ColorManager.primary,
                                ),
                              ),
                          ],
                        )),
                    onTap: () {
                      if (cubit.invoice1 == false) {
                        navigateTo(context, GeneralInformation(invoiceNumber));
                      }
                    },
                  ),
                  InkWell(
                    child: Card(
                        margin: const EdgeInsets.all(5),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: 3,
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                IconBroken.User,
                                size: 32,
                                color: ColorManager.primary,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                IconBroken.Arrow___Left_2,
                                color: ColorManager.primary,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "بيانات العميل",
                                    style: getSemiBoldStyle(
                                        color: ColorManager.black,
                                        fontSize: 18),
                                  ),
                                  Text(
                                    "أضف بيانات عميلك",
                                    style: getSemiBoldStyle(
                                        color: ColorManager.gray, fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            if (cubit.invoice2)
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.check_circle_outline,
                                  size: 25,
                                  color: ColorManager.primary,
                                ),
                              ),
                          ],
                        )),
                    onTap: () {
                      if (cubit.invoice2 == false) {
                        navigateTo(context, CustomerInformation());
                      }
                    },
                  ),
                  InkWell(
                    child: Card(
                        margin: const EdgeInsets.all(5),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: 3,
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                IconBroken.Buy,
                                size: 32,
                                color: ColorManager.primary,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                IconBroken.Arrow___Left_2,
                                color: ColorManager.primary,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "المشتريات",
                                    style: getSemiBoldStyle(
                                        color: ColorManager.black,
                                        fontSize: 18),
                                  ),
                                  Text(
                                    "إختر مشتريات العميل",
                                    style: getSemiBoldStyle(
                                        color: ColorManager.gray, fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            if (cubit.invoice3)
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.check_circle_outline,
                                  size: 25,
                                  color: ColorManager.primary,
                                ),
                              ),
                          ],
                        )),
                    onTap: () {
                      if (cubit.invoice3 == false) {
                        navigateTo(context, CustomerProducts());
                      }
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(ColorManager.primary),
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)))),
                        onPressed: () {
                          //
                          if (cubit.invoice2 &&
                              cubit.invoice3 &&
                              cubit.invoice1) {

                          }
                        },
                        child: Text(
                          "معاينة",
                          style: getRegularStyle(
                              color: ColorManager.white, fontSize: 16),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      TextButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(ColorManager.primary),
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)))),
                        onPressed: () {
                          if (cubit.invoice2 &&
                              cubit.invoice3 &&
                              cubit.invoice1) {

                          }
                        },
                        child: Text(
                          "حفظ",
                          style: getRegularStyle(
                              color: ColorManager.white, fontSize: 16),
                        ),
                      )
                    ],
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
