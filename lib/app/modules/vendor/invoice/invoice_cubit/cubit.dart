import 'dart:io';
import 'dart:math';
import 'package:bill_hub/app/model/complaint.dart';
import 'package:bill_hub/app/model/invoice.dart';
import 'package:bill_hub/app/model/product.dart';
import 'package:bill_hub/app/model/vendor.dart';
import 'package:bill_hub/app/modules/vendor/invoice/invoice_cubit/states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_filex/open_filex.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../model/analysis.dart';
import '../../../../model/invoice_item.dart';
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
  String? value;

  change1(bool status) {
    invoice1 = status;
    emit(Invoice1State());
  }

  change2(bool status) {
    invoice2 = status;
    emit(Invoice2State());
  }

  change3(bool status) {
    invoice3 = status;
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

  removeAllProductToList() {
    customerProducts.clear();
    calculateAmount();
    emit(InvoiceClearListState());
  }

  calculateAmount() {
    total = 0.0;
    customerProducts.forEach((element) {
      double x = element.amount!.toDouble();
      total += (element.price! * x);
    });
    emit(InvoiceCalculateAmountState());
  }

  double? price;
  getProductPrice(String productName) {
    emit(GetProductPriceLoadingState());
    allVendorProducts.forEach((element) {
      if (element.name == productName) {
        price = element.price;
        emit(GetProductPriceSuccessState());
      }
    });
  }

  changeDropDown(String value) {
    this.value = value;
    emit(Invoice3State());
  }

  Future<File> generatePDF(
      Invoice invoice, bool uploadFile, String createDate) async {
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
    return await savePDF(invoice.invoiceId!, '${invoice.invoiceId}.pdf', pdf,
        uploadFile, createDate);
  }

  Future<File> savePDF(String invoiceId, String fileName, Document pdf,
      bool uploadFile, createDate) async {
    final bytes = await pdf.save();
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$fileName');
    file.writeAsBytes(bytes);
    if (uploadFile == true) {
      uploadInvoice(file, invoiceId, createDate);
    }
    return file;
  }

  Future openFile(File file) async {
    final url = file.path;
    await OpenFilex.open(url);
  }

  String? fileURl;
  uploadInvoice(file, String invoiceNumber, createDate) {
    emit(UploadInvoiceLoadingState());
    FirebaseStorage.instance
        .ref()
        .child('Invoice/${Uri.file(file!.path).pathSegments.last}')
        .putFile(file!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        fileURl = value;
        CreateInvoice(
            invoiceNumber: invoiceNumber,
            creationDate: createDate,
            endDate: expDate,
            vendorId: vendorModel!.uid!,
            fileUrl: fileURl!,
            buyerName: customerName,
            buyerPhone: customerPhone,
            isPaid: false);
        emit(UploadInvoiceSuccessState());
      }).catchError((e) {
        emit(UploadInvoiceErrorState());
      });
    }).catchError((error) {
      emit(UploadInvoiceErrorState());
      print(error.toString());
    });
  }

  Vendor? vendorModel;
  void getVendorData(String uid) {
    emit(GetVendorLoadingState());
    FirebaseFirestore.instance
        .collection('Vendor')
        .doc(uid)
        .get()
        .then((value) {
      vendorModel = Vendor.fromMap(value.data()!);
      print(vendorModel!.email);
      emit(GetVendorSuccessState());
    }).catchError((e) {
      emit(GetVendorErrorState());
    });
  }

  AddVendorProduct({
    required String name,
    required double price,
    required int amount,
  }) async {
    emit(AddProductLoadingState());
    String productId = await generateRandomString(25);
    Product product = Product(productId, name, price, amount, false);
    FirebaseFirestore.instance
        .collection('All Products')
        .doc(vendorModel!.uid)
        .collection('Products')
        .doc(productId)
        .set(product.toMap()!)
        .then((value) {
      emit(AddProductSuccessState());
    }).catchError((e) {
      emit(AddProductErrorState());
    });
  }

  List<Product> allVendorProducts = [];
  List<String> allProducts = [];
  GetVendorProducts() {
    emit(GetProductLoadingState());
    allVendorProducts = [];
    allProducts = [];
    FirebaseFirestore.instance
        .collection('All Products')
        .doc(vendorModel!.uid)
        .collection('Products')
        .get()
        .then((value) {
      for (var element in value.docs) {
        allVendorProducts.add(Product.fromMap(element.data()));
        allProducts.add(Product.fromMap(element.data()).name!);
      }
      emit(GetProductSuccessState());
    }).catchError((e) {
      emit(GetProductErrorState());
    });
  }

  void HideProducts({
    required String productId,
    required bool hide,
    required int index,
  }) {
    Product product = Product(productId, allVendorProducts[index].name,
        allVendorProducts[index].price, allVendorProducts[index].amount, hide);
    FirebaseFirestore.instance
        .collection('All Products')
        .doc(vendorModel!.uid)
        .collection('Products')
        .doc(productId)
        .update(product.toMap()!)
        .then((value) {
      emit(HideProductSuccessState());
    }).catchError((e) {
      emit(HideProductErrorState());
    });
  }

  EditVendorProduct({
    required String name,
    required double price,
    required String productId,
    required bool hide,
    required int amount,
  }) async {
    emit(EditProductLoadingState());
    Product product = Product(productId, name, price, amount, hide);
    FirebaseFirestore.instance
        .collection('All Products')
        .doc(vendorModel!.uid)
        .collection('Products')
        .doc(productId)
        .update(product.toMap()!)
        .then((value) {
      emit(EditProductSuccessState());
    }).catchError((e) {
      emit(EditProductErrorState());
    });
  }

  CreateInvoice({
    required String invoiceNumber,
    required String creationDate,
    required String endDate,
    required String vendorId,
    required String fileUrl,
    required String buyerName,
    required String buyerPhone,
    required bool isPaid,
  }) async {
    emit(CreateInvoiceLoadingState());
    String InvoiceId = await generateRandomString(25);
    InvoiceItem invoiceItem = InvoiceItem(
        invoiceNumber,
        InvoiceId,
        creationDate,
        endDate,
        vendorId,
        fileUrl,
        buyerName,
        buyerPhone,
        isPaid);
    FirebaseFirestore.instance
        .collection('All Invoices')
        .doc(InvoiceId)
        .set(invoiceItem.toMap()!)
        .then((value) {
      emit(CreateInvoiceSuccessState());
    }).catchError((e) {
      emit(CreateInvoiceErrorState());
    });
  }

  List<InvoiceItem> allVendorInvoices = [];
  GetAllVendorInvoice() {
    allVendorInvoices = [];
    emit(GetAllInvoiceLoadingState());
    FirebaseFirestore.instance
        .collection('All Invoices')
        .where('vendorId', isEqualTo: vendorModel!.uid)
        .get()
        .then((value) {
      for (var element in value.docs) {
        allVendorInvoices.add(InvoiceItem.fromMap(element.data()));
      }
      emit(GetAllInvoiceSuccessState());
    }).catchError((e) {
      emit(GetAllInvoiceErrorState());
    });
  }

  AddComplaint({
    required String title,
    required String description,
    required String date,
  }) async {
    emit(AddComplaintLoadingState());
    String complaintId = await generateRandomString(25);
    Complaint complaint = Complaint(complaintId, title, vendorModel!.name,
        'Vendor', description, false, '', date, vendorModel!.uid);
    FirebaseFirestore.instance
        .collection('All Complaints')
        .doc(complaintId)
        .set(complaint.toMap()!)
        .then((value) {
      emit(AddComplaintSuccessState());
    }).catchError((e) {
      emit(AddComplaintErrorState());
    });
  }

  List<Complaint> allVendorComplaint = [];
  GetVendorComplaint() {
    allVendorComplaint = [];
    emit(GetComplaintLoadingState());
    FirebaseFirestore.instance
        .collection('All Complaints')
        .where('userId', isEqualTo: vendorModel!.uid)
        .get()
        .then((value) {
      for (var element in value.docs) {
        allVendorComplaint.add(Complaint.fromMap(element.data()));
      }
      emit(GetComplaintSuccessState());
    }).catchError((e) {
      emit(GetComplaintErrorState());
    });
  }

  void setNewUserSales({required String userId}) {
    Map<String, int> data = {
      'Jan': 0,
      'Feb': 0,
      'Mar': 0,
      'Apr': 0,
      'May': 0,
      'Jun': 0,
      'Jul': 0,
      'Aug': 0,
      'Sep': 0,
      'Oct': 0,
      'Nov': 0,
      'Dec': 0,
    };
    FirebaseFirestore.instance
        .collection('Analysis')
        .doc(userId)
        .set(data)
        .then((value) {
      emit(SetAnalysisSuccessState());
    }).catchError((e) {
      emit(SetAnalysisErrorState());

    });
  }

  List<Sales> allSales = [];
  void GetSales() {
    FirebaseFirestore.instance
        .collection('Analysis')
        .doc(vendorModel!.uid)
        .get()
        .then((value) {
      allSales.add(Sales.fromMap(value.data()!));
      emit(GetAnalysisSuccessState());
    }).catchError((e) {
      emit(GetAnalysisErrorState());
    });
  }

  int getMonthSales(String month) {
    int monthSales=0;
    allSales.forEach((element) {
      if (element.month == month) {
        monthSales = element.numOfSales!;
      }
    });
    return monthSales;
  }

  void updateSales({
    required String month,
  }) {
    int newValue = getMonthSales(month);
    Sales sales = Sales(month, newValue++);
    FirebaseFirestore.instance
        .collection('Analysis')
        .doc(vendorModel!.uid)
        .update(sales.toMap()!)
        .then((value) {
      emit(UpdateAnalysisSuccessState());
    }).catchError((e) {
      emit(UpdateAnalysisErrorState());
    });
  }



  List<InvoiceItem> allInvoiceForVisitor = [];
  GetAllInvoice() {
    allInvoiceForVisitor = [];
    FirebaseFirestore.instance
        .collection('All Invoices')
        .get()
        .then((value) {
      for (var element in value.docs) {
        allInvoiceForVisitor.add(InvoiceItem.fromMap(element.data()));
      }
      emit(GetAllInvoiceSuccessState());
    }).catchError((e) {
      emit(GetAllInvoiceErrorState());
    });
  }

  InvoiceItem? search(String value){
    InvoiceItem? x;
    allInvoiceForVisitor.forEach((element) {
      if(element.invoiceNumber==value){
        print('${element.invoiceNumber}');
        x = element;
      }
    });
    emit(ChangeSearchListState());
    return x;
  }
  void payInvoice({
    required InvoiceItem Item

  }){
    emit(PayInvoiceLoadingState());
    InvoiceItem invoiceItem = InvoiceItem(
        Item.invoiceNumber,
        Item.invoiceId,
        Item.creationDate,
        Item.endDate,
        Item.vendorId,
        Item.fileUrl,
        Item.buyerName,
        Item.buyerPhone,
        true);
    FirebaseFirestore.instance
        .collection('All Invoices')
        .doc(Item.invoiceId)
        .set(invoiceItem.toMap()!)
        .then((value) {
      emit(PayInvoiceSuccessState());
    }).catchError((e) {
      emit(PayInvoiceErrorState());
    });
  }

  String generateRandomString(int len) {
    var r = Random();
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)])
        .join();
  }
}
