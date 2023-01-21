import 'package:bill_hub/app/modules/vendor/invoice/invoice_cubit/cubit.dart';
import 'package:bill_hub/app/modules/vendor/invoice/invoice_cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:share_plus/share_plus.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/styles_manager.dart';

class ViewInvoicePdf extends StatelessWidget {
  String url;
  ViewInvoicePdf(this.url,{Key? key}) : super(key: key);

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
        );
      },
    );
  }
}
