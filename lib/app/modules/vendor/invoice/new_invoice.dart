import 'dart:math';
import 'dart:io';
import 'package:bill_hub/app/model/buyer.dart';
import 'package:bill_hub/app/model/invoice.dart';
import 'package:bill_hub/app/model/vendor.dart';
import 'package:bill_hub/app/modules/vendor/invoice/invoice_cubit/cubit.dart';
import 'package:bill_hub/app/modules/vendor/invoice/invoice_cubit/states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
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
      listener: (context, state) {
        if (state is CreateInvoiceSuccessState) {
          var cubit = InvoiceCubit.getCubit(context);
          cubit.change1(false);
          cubit.change2(false);
          cubit.change3(false);
          cubit.expDate = '';
          cubit.removeAllProductToList();
          cubit.GetAllVendorInvoice();
          var formatter = new DateFormat('MMMM');
          String month = formatter. format(now);
          cubit.updateSales(month: month.substring(0,3));
          Navigator.pop(context);
        }
      },
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
                        onPressed: () async {
                          if (cubit.invoice2 &&
                              cubit.invoice3 &&
                              cubit.invoice1) {
                            Invoice invoice = Invoice(
                                '$invoiceNumber',
                                '$invoiceNumber',
                                '${formatter.format(now)}',
                                '${cubit.expDate}',
                                Buyer(uid, cubit.customerName, 'email',
                                    cubit.customerPhone),
                                Vendor(
                                    cubit.vendorModel!.uid,
                                    cubit.vendorModel!.name,
                                    cubit.vendorModel!.email,
                                    cubit.vendorModel!.phone,
                                    cubit.vendorModel!.companyName,
                                    cubit.vendorModel!.companyType,
                                    cubit.vendorModel!.employment,
                                    false,
                                    'blockReason'),
                                cubit.customerProducts);
                            File file = await cubit.generatePDF(
                                invoice, false, '${formatter.format(now)}');
                            await cubit.openFile(file);
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
                        onPressed: () async {
                          if (cubit.invoice2 &&
                              cubit.invoice3 &&
                              cubit.invoice1) {
                            Invoice invoice = Invoice(
                                '$invoiceNumber',
                                '$invoiceNumber',
                                '${formatter.format(now)}',
                                '${cubit.expDate}',
                                Buyer(uid, cubit.customerName, 'email',
                                    cubit.customerPhone),
                                Vendor(
                                    cubit.vendorModel!.uid,
                                    cubit.vendorModel!.name,
                                    cubit.vendorModel!.email,
                                    cubit.vendorModel!.phone,
                                    cubit.vendorModel!.companyName,
                                    cubit.vendorModel!.companyType,
                                    cubit.vendorModel!.employment,
                                    false,
                                    'blockReason'),
                                cubit.customerProducts);
                            await cubit.generatePDF(
                                invoice, true, '${formatter.format(now)}');

                          }
                        },
                        child: ConditionalBuilder(
                          condition: state is! UploadInvoiceLoadingState,
                          builder: (context) => Text(
                            "حفظ",
                            style: getRegularStyle(
                                color: ColorManager.white, fontSize: 16),
                          ),
                          fallback: (context) => const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              backgroundColor: Colors.white,
                            ),
                          ),
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
