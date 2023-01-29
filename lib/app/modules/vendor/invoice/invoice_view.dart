import 'package:bill_hub/app/modules/vendor/invoice/invoice_cubit/cubit.dart';
import 'package:bill_hub/app/modules/vendor/invoice/view_invoice_pdf.dart';
import 'package:bill_hub/shared/components/component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../styles/icons_broken.dart';
import '../../../model/invoice_item.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/styles_manager.dart';
import 'invoice_cubit/states.dart';
import 'new_invoice.dart';

class InvoiceVendorView extends StatefulWidget {
  const InvoiceVendorView({Key? key}) : super(key: key);

  @override
  State<InvoiceVendorView> createState() => _InvoiceVendorViewState();
}

class _InvoiceVendorViewState extends State<InvoiceVendorView> {
  @override
  void initState() {
    super.initState();
    InvoiceCubit.getCubit(context).GetAllVendorInvoice();
    InvoiceCubit.getCubit(context).GetVendorProducts();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InvoiceCubit, InvoiceStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'الفواتير',
              style: getSemiBoldStyle(color: ColorManager.white, fontSize: 20),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  if(InvoiceCubit.getCubit(context).allVendorProducts.isEmpty){
                    showAlertDialog(context);
                  }else{
                    navigateTo(context, NewInvoiceView());
                  }
                },
                color: ColorManager.primary,
                icon: Icon(
                  IconBroken.Plus,
                  color: ColorManager.white,
                ),
              ),
            ],
          ),
          body: ViewInvoiceListView(context),
        );
      },
    );
  }

  Widget ViewInvoiceListView(context) {
    var cubit = InvoiceCubit.getCubit(context);
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return ViewInvoiceItemBuilder(
                  cubit.allVendorInvoices[index], context);
            },
            separatorBuilder: (context, index) => const SizedBox(
              height: 2,
            ),
            itemCount: cubit.allVendorInvoices.length,
          ),
        ],
      ),
    );
  }

  Widget ViewInvoiceItemBuilder(InvoiceItem invoiceItem, context) {
    return InkWell(
      onTap: () {
        navigateTo(
          context,
          ViewInvoicePdf(invoiceItem.fileUrl!,false));
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
                              color: ColorManager.darkGray, fontSize: 12),
                        ),
                        Text(
                          "${invoiceItem.invoiceNumber}#",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: getSemiBoldStyle(
                              color: ColorManager.black, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () async{
                    SharePDF(invoiceItem.fileUrl!,invoiceItem.invoiceNumber!);
                  },
                  icon: Icon(
                    Icons.share,
                    color: ColorManager.primary,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            )),
      ),
    );
  }
  Future<void> SharePDF(String pdfUrl,String invoiceNumber) async {
    String message = 'رقم الفاتورة';
    String link = 'رابط تحميل الفاتورة';
    await Share.share('$message $invoiceNumber \n$link $pdfUrl');
  }


  Future showAlertDialog(context) => showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "تنبية",
                style: getBoldStyle(
                    color: ColorManager.darkGray, fontSize: 18),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "لقد علمنا ان حسابك لا يحتوي علي منتجات بعد\nلذلك لا يمكنك إنشاء فاتورة جديدة\nإلا بعد توفر المنتجات",
                    style: getSemiBoldStyle(
                        color: ColorManager.darkGray, fontSize: 14),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    style: ButtonStyle(
                        shape: MaterialStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        backgroundColor:
                        MaterialStatePropertyAll(ColorManager.primary)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "حسنا",
                      style: getRegularStyle(color: ColorManager.white),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      );
    },
  );
}
