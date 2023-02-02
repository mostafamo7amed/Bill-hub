import 'package:bill_hub/app/model/invoice_item.dart';
import 'package:bill_hub/app/modules/vendor/invoice/view_invoice_pdf.dart';
import 'package:bill_hub/shared/components/component.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../styles/icons_broken.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/styles_manager.dart';
import '../home/buyer_cubit/cubit.dart';
import '../home/buyer_cubit/states.dart';

class InvoiceBuyerView extends StatelessWidget {
  InvoiceBuyerView({Key? key}) : super(key: key);
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    BuyerCubit.getCubit(context).GetAllBuyerInvoice();
    return BlocConsumer<BuyerCubit, BuyerStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = BuyerCubit.getCubit(context);
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                'الفواتير',
                style:
                    getSemiBoldStyle(color: ColorManager.white, fontSize: 20),
              ),
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10.0,
                    right: 10,
                    top: 10,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          onChanged: (value) {
                            cubit.search(value);
                          },
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
                      children: [
                        ConditionalBuilder(
                          condition: cubit.allBuyerPaidInvoices.isNotEmpty,
                          builder: (context) => ManagePaidBillListView(context),
                          fallback: (context) => Center(
                              child: Text(
                            'لا توجد فواتير حاليا',
                            style: getSemiBoldStyle(
                                color: ColorManager.black, fontSize: 16),
                          )),
                        ),
                        ConditionalBuilder(
                          condition: cubit.allBuyerInvoices.isNotEmpty,
                          builder: (context) => ManageBillListView(context),
                          fallback: (context) => Center(
                              child: Text(
                            'لا توجد فواتير حاليا',
                            style: getSemiBoldStyle(
                                color: ColorManager.black, fontSize: 16),
                          )),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget ManageBillListView(context) {
    return BlocConsumer<BuyerCubit, BuyerStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = BuyerCubit.getCubit(context);
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              searchController.text.isNotEmpty && cubit.searchList.isEmpty
                  ? Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 30,
                            color: ColorManager.primary,
                          ),
                          Text(
                            'لا توجد فواتير',
                            style: getSemiBoldStyle(
                                color: ColorManager.darkGray, fontSize: 16),
                          ),
                        ],
                      ),
                    )
                  : ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        if (searchController.text.isNotEmpty &&
                            cubit.searchList.isNotEmpty) {
                          return BillItemBuilder(
                              cubit.searchList[index], context,index);
                        } else {
                          return BillItemBuilder(
                              cubit.allBuyerInvoices[index], context,index);
                        }
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 2,
                      ),
                      itemCount: searchController.text.isNotEmpty &&
                              cubit.searchList.isNotEmpty
                          ? cubit.searchList.length
                          : cubit.allBuyerInvoices.length,
                    ),
            ],
          ),
        );
      },
    );
  }

  Widget ManagePaidBillListView(context) {
    var cubit = BuyerCubit.getCubit(context);
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          searchController.text.isNotEmpty && cubit.searchPaidList.isEmpty
              ? Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.search_off,
                        size: 30,
                        color: ColorManager.primary,
                      ),
                      Text(
                        'لا توجد فواتير',
                        style: getSemiBoldStyle(
                            color: ColorManager.darkGray, fontSize: 16),
                      ),
                    ],
                  ),
                )
              : ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    if (searchController.text.isNotEmpty &&
                        cubit.searchPaidList.isNotEmpty) {
                      return BillItemBuilder(
                          cubit.searchPaidList[index], context,index);
                    } else {
                      return BillItemBuilder(
                          cubit.allBuyerPaidInvoices[index], context,index);
                    }
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 2,
                  ),
                  itemCount: searchController.text.isNotEmpty &&
                          cubit.searchPaidList.isNotEmpty
                      ? cubit.searchPaidList.length
                      : cubit.allBuyerPaidInvoices.length,
                ),
        ],
      ),
    );
  }

  Widget BillItemBuilder(InvoiceItem invoiceItem, context,index) {
    return InkWell(
      onTap: () {
        navigateTo(context, ViewInvoicePdf(invoiceItem.fileUrl!, true,'buyer',index,null));
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
                  child: Icon(
                    IconBroken.Document,
                    size: 32,
                    color: ColorManager.primary,
                  ),
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
                          "#${invoiceItem.invoiceNumber}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: getSemiBoldStyle(
                              color: ColorManager.black, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
                invoiceItem.isPaid!
                    ? Text(
                        "تم السداد",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: getSemiBoldStyle(
                            color: ColorManager.gray, fontSize: 12),
                      )
                    : Text(
                        "لم يتم السداد",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: getSemiBoldStyle(
                            color: ColorManager.gray, fontSize: 12),
                      ),
                SizedBox(
                  width: 10,
                ),
              ],
            )),
      ),
    );
  }

  /* Future showBillInfoDialog(context) => showDialog(
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
  );*/
}
