import 'package:bill_hub/shared/components/component.dart';
import 'package:flutter/material.dart';
import '../../../../styles/icons_broken.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/styles_manager.dart';
import 'new_invoice.dart';

class InvoiceVendorView extends StatelessWidget {
  const InvoiceVendorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'الفواتير',
          style: getSemiBoldStyle(color: ColorManager.white, fontSize: 20),
        ),
        actions: [
          IconButton(
            onPressed: () {
              navigateTo(context, NewInvoiceView());
            },
            color: ColorManager.primary,
            icon: Icon(IconBroken.Plus,color: ColorManager.white,),
          ),
        ],
      ),
      body: ViewInvoiceListView(),
    );
  }

  Widget ViewInvoiceListView() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ViewInvoiceItemBuilder(context);
              },
              separatorBuilder: (context, index) => const SizedBox(
                height: 2,
              ),
              itemCount: 2 // todo list students
          ),
        ],
      ),
    );
  }

  Widget ViewInvoiceItemBuilder(context) {
    return InkWell(
      onTap: () {
        //showBillInfoDialog(context);
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
                              color: ColorManager.darkGray, fontSize: 12),
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
                SizedBox(width: 10,),
              ],
            )),
      ),
    );
  }

}
