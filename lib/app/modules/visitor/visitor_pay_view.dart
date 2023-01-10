import 'package:bill_hub/app/modules/visitor/payment.dart';
import 'package:flutter/material.dart';

import '../../../shared/components/component.dart';
import '../../../styles/icons_broken.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/styles_manager.dart';

class VisitorPayView extends StatelessWidget {
  VisitorPayView({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  var billController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('دفع فاتورة',style: getSemiBoldStyle(color: ColorManager.white,fontSize: 20),),
      ),
      backgroundColor: ColorManager.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
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
                      //ToDo view user
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
