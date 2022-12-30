import 'package:flutter/material.dart';

import '../../../resources/color_manager.dart';
import '../../../resources/styles_manager.dart';

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
      ),
    );
  }
}
