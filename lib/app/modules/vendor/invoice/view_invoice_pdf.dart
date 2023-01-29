import 'package:bill_hub/app/modules/vendor/invoice/invoice_cubit/cubit.dart';
import 'package:bill_hub/app/modules/vendor/invoice/invoice_cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import '../../../../shared/components/component.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/styles_manager.dart';
import '../../visitor/payment.dart';

class ViewInvoicePdf extends StatelessWidget {
  String url;
  bool paid;
  ViewInvoicePdf(this.url,this.paid,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InvoiceCubit,InvoiceStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'الفاتورة',
              style: getSemiBoldStyle(color: ColorManager.white, fontSize: 20),
            ),
          ),
          body: Center(
              child: PDF().fromUrl(url,
                placeholder: (double progress) =>
                    Center(child: Text('$progress %',style: getRegularStyle(color:ColorManager.primary ),)),
                errorWidget: (dynamic error) =>
                    Center(child: Text(error.toString(),style: getRegularStyle(color:ColorManager.primary ),)),

            ),
          ),
          bottomNavigationBar: paid?
          Container(
            child:  Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                style: ButtonStyle(
                    backgroundColor:
                    MaterialStatePropertyAll(ColorManager.primary)),
                onPressed: () {
                  showPaymentDialog(context);
                },
                child: Text(
                  "دفع الفاتورة",
                  style: getRegularStyle(color: ColorManager.white,fontSize: 16),
                ),
              ),
            ),
          ):SizedBox(),
        );
      },
    );
  }
  Future showPaymentDialog(context) => showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "أختر طريقة الدفع",
                  style: getBoldStyle(
                      color: ColorManager.darkGray, fontSize: 18),
                ),
                InkWell(
                  onTap: () => navigateTo(context, PaymentView()),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Container(
                        width: double.infinity,
                        child: Image.asset(ImageAssets.paypal,width: 20,height: 25,)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 0.0,
                      horizontal: 10.0
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 1.0,
                    color: Colors.grey[300],
                  ),
                ),
                InkWell(
                  onTap: () =>  navigateTo(context, PaymentView()),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Container(
                        width: double.infinity,
                        child: Image.asset(ImageAssets.masterCard,width: 30,height: 30,)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 0.0,
                      horizontal: 10.0
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 1.0,
                    color: Colors.grey[300],
                  ),
                ),
                InkWell(
                  onTap: () =>  navigateTo(context, PaymentView()),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Container(
                        width: double.infinity,
                        child: Image.asset(ImageAssets.visa,width: 20,height: 25,)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 0.0,
                      horizontal: 10.0
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 1.0,
                    color: Colors.grey[300],
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Container(
                        width: double.infinity,
                        child: Image.asset(ImageAssets.applePay,width: 30,height: 30,)),
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
