import 'dart:io';
import 'package:bill_hub/app/model/invoice.dart';
import 'package:bill_hub/app/model/product.dart';
import 'package:bill_hub/app/modules/vendor/invoice/invoice_cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_filex/open_filex.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:path_provider/path_provider.dart';

import '../invoice_build_components.dart';

class InvoiceCubit extends Cubit<InvoiceStates> {
  InvoiceCubit() : super(InvoiceInitState());

  static InvoiceCubit getCubit(context) => BlocProvider.of(context);

  bool invoice1 = false;
  bool invoice2 = false;
  bool invoice3 = false;

  String expDate = '';
  String customerName = '';
  String customerPhone = '';
  List<Product> customerProducts = [];
  double total = 0.0;
  List<String> items = ['لاب توب', 'أيفون'];
  String? value;

  change1() {
    invoice1 = true;
    emit(Invoice1State());
  }

  change2() {
    invoice2 = true;
    emit(Invoice2State());
  }

  change3() {
    invoice3 = true;
    emit(Invoice3State());
  }

  changeExpDate(String date) {
    expDate = date;
    emit(InvoiceExpDateState());
  }

  changeCustomerData(String name, String phone) {
    customerName = name;
    customerPhone = phone;
    emit(InvoiceCustomerDataState());
  }

  addProductToList(Product product) {
    customerProducts.add(product);
    calculateAmount();
    emit(InvoiceAddProductToListState());
  }

  removeProductToList(index) {
    customerProducts.removeAt(index);
    calculateAmount();
    emit(InvoiceRemoveProductToListState());
  }

  calculateAmount() {
    total = 0.0;
    customerProducts.forEach((element) {
      double x = element.amount!.toDouble();
      total += (element.price! * x);
    });
    emit(InvoiceCalculateAmountState());
  }

  changeDropDown(String value) {
    this.value = value;
    emit(Invoice3State());
  }

  Future<File> generatePDF(Invoice invoice) async {
    final pdf = Document();
    pdf.addPage(
      MultiPage(
        crossAxisAlignment: CrossAxisAlignment.end,
        textDirection: TextDirection.rtl,
        theme: ThemeData.withFont(
          base: arFont,
        ),
        build: (context) => [
          buildHeader(invoice),
          SizedBox(height: 1 * PdfPageFormat.cm),
          buildTitle(),
          buildInvoiceProduct(invoice),
          Divider(),
          buildTotal(total),
        ],
        footer: (context) => buildFooter(invoice),
      ),
    );
    return await savePDF('${invoice.invoiceId}.pdf', pdf);
  }

  Future<File> savePDF(String fileName, Document pdf) async {
    final bytes = await pdf.save();
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$fileName');
    file.writeAsBytes(bytes);
    return file;
  }

  Future openFile(File file) async {
    final url = file.path;
    await OpenFilex.open(url);
  }
}
