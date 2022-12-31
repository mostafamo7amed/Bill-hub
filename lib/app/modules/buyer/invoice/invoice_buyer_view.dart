import 'package:bill_hub/app/modules/visitor/visitor_pay_view.dart';
import 'package:bill_hub/shared/components/component.dart';
import 'package:flutter/material.dart';

import '../../../../styles/icons_broken.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/styles_manager.dart';
import '../../visitor/payment.dart';

class InvoiceBuyerView extends StatelessWidget {
  InvoiceBuyerView({Key? key}) : super(key: key);
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'الفواتير',
            style: getSemiBoldStyle(color: ColorManager.white, fontSize: 20),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0,right: 10,top: 5,),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: searchController,
                      style: getRegularStyle(
                          color: ColorManager.black, fontSize: 16),
                      decoration: InputDecoration(
                        label: Padding(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Text('بحث',
                              style: getRegularStyle(
                                  color: ColorManager.black, fontSize: 16)),
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: ColorManager.darkGray,
                        ),
                        border: const OutlineInputBorder(),
                        labelStyle: getRegularStyle(
                            color: ColorManager.black, fontSize: 16),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return '';
                        }
                        return null;
                      },
                      onFieldSubmitted: (value) {},
                      keyboardType: TextInputType.text,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: double.infinity,
              child: TabBar(
                labelColor: Colors.red,
                isScrollable: true,
                unselectedLabelColor: Colors.black,
                indicatorColor: Colors.red,
                indicatorPadding: EdgeInsets.all(15),
                physics: BouncingScrollPhysics(),
                tabs: [
                  Tab(text: "تم السداد"),
                  Tab(text: "لم يتم السداد"),
                ],
              ),
            ),
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: TabBarView(
                    physics: BouncingScrollPhysics(),
                    children: [ManageBillListView(), ManageBillListView()]),
              ),
            ),
         ],
        ),
      ),
    );
  }
  Widget ManageBillListView() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return BillItemBuilder(context);
              },
              separatorBuilder: (context, index) => const SizedBox(
                height: 2,
              ),
              itemCount: 10 // todo list students
          ),
        ],
      ),
    );
  }

  Widget BillItemBuilder(context) {
    return InkWell(
      onTap: () {
        showBillInfoDialog(context);
      },
      child: Padding(
        padding: const EdgeInsets.only(
          left: 5,
          right: 5,
        ),
        child: Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: 5,
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(IconBroken.Document,size: 32,color: ColorManager.primary,),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "رقم الفاتورة",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: getSemiBoldStyle(
                              color: ColorManager.gray, fontSize: 12),
                        ),
                        Text(
                          "#123412421",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: getSemiBoldStyle(
                              color: ColorManager.black, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
                Text(
                  "لم يتم السداد",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: getSemiBoldStyle(
                      color: ColorManager.gray, fontSize: 12),
                ),
                SizedBox(width: 10,),
              ],
            )),
      ),
    );
  }

  Future showBillInfoDialog(context) => showDialog(
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
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "بيانات الفاتورة",
                  style: getBoldStyle(
                      color: ColorManager.black, fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(ColorManager.primary),
                          shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        showPaymentDialog(context);
                      },
                      child: Text(
                        "دفع",
                        style: getRegularStyle(color: ColorManager.white, fontSize: 16),
                      ),
                    ),
                    SizedBox(width: 10,),
                    TextButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(ColorManager.primary),
                          shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))
                      ),
                      onPressed: () {
                      },
                      child: Text(
                        "معاينة",
                        style: getRegularStyle(color: ColorManager.white, fontSize: 16),
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
                  onTap: () =>  navigateTo(context, PaymentView()),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Container(
                        width: double.infinity,
                        child: Image.asset(ImageAssets.googlePay,width: 30,height: 30,)),
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
