import 'package:bill_hub/app/model/invoice.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '../../../model/buyer.dart';
import '../../../model/vendor.dart';

Widget buildHeader(Invoice invoice) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 1 * PdfPageFormat.cm),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 50,
              width: 50,
              child: BarcodeWidget(
                barcode: Barcode.qrCode(),
                data: invoice.invoiceId!,
              ),
            ),
            buildSupplierAddress(invoice.vendor!),
          ],
        ),
        SizedBox(height: 1 * PdfPageFormat.cm),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            buildInvoiceInfo(invoice),
            Spacer(),
            Expanded(child: buildCustomerAddress(invoice.buyer!),)

          ],
        ),
      ],
    );

Widget buildSupplierAddress(Vendor supplier) => Column(
  crossAxisAlignment: CrossAxisAlignment.end,
  children: [
        Text(
          'البائع :',
        ),
        Text(
          supplier.name!,
        ),
        SizedBox(height: 1 * PdfPageFormat.mm),
        Text(supplier.phone!),
      ],
    );

Widget buildInvoiceInfo(Invoice info) {
  final titles = <String>['رقم الفاتورة : ', 'تاريخ الانشاء : ', 'تاريخ الانتهاء : '];
  final data = <String>[
    info.invoiceId!,
    info.creationDate!,
    info.endDate!,
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: List.generate(titles.length, (index) {
      final value = data[index];
      final title = titles[index];

      return buildText(title: title, value: value, width: 200);
    }),
  );
}

Widget buildCustomerAddress(Buyer buyer) => Column(
  crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'المشتري :',
        ),
        Text(
          buyer.name!,
        ),
        Text(
          buyer.phone!,
        ),
      ],
    );


Widget buildTitle() =>
    Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Text(
        'بيانات المشتريات ',
      ),
      SizedBox(height: 0.8 * PdfPageFormat.cm),
    ]);

Widget buildInvoiceProduct(Invoice invoice) {
  final headers = [
    'الاجمالي',
    'الكمية',
    'السعر',
    'المنتج',
  ];
  final data = invoice.product!.map((item) {
    final total = item.price! * item.amount!.toDouble();
    return [
      '${total.toStringAsFixed(1)} \$',
      '${item.amount}',
      '${item.price} \$',
      item.name,
    ];
  }).toList();

  return Table.fromTextArray(
      headers: headers,
      data: data,
      border: null,
      headerDecoration: BoxDecoration(color: PdfColors.grey300),
      cellHeight: 30,
      cellAlignments: {
        0: Alignment.centerRight,
        1: Alignment.centerRight,
        2: Alignment.centerRight,
        3: Alignment.centerRight,
      });
}

Widget buildTotal(double total) {
  return Container(
    alignment: Alignment.centerRight,
    child: Row(
      children: [
        Spacer(flex: 6),
        Expanded(
          flex: 4,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
                child: Row(children: [
              Text('$total \$',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Expanded(
                  child: Text(
                'الاجمالي',
              )),
            ])),
            Divider(),
          ]),
        ),
      ],
    ),
  );
}

Widget buildFooter(Invoice invoice) =>
    Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Divider(),
      SizedBox(height: 2 * PdfPageFormat.mm),
      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        Text('${invoice.vendor!.companyName}'),
        SizedBox(width: 1 * PdfPageFormat.mm),
        Text('شركة'),
      ]),
    ]);

late Font arFont;
initFont() async {
  arFont = Font.ttf((await rootBundle.load('assets/fonts/Cairo-SemiBold.ttf')));
}

buildText({
  required String title,
  required String value,
  double width = double.infinity,
  TextStyle? titleStyle,
  bool unite = false,
}) {
  return Container(
    width: width,
    child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(value,),
        Expanded(child: Text(title,)),
      ],
    ),
  );
}
