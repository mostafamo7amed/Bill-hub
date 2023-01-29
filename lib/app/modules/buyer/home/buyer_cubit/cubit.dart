import 'dart:math';

import 'package:bill_hub/app/model/buyer.dart';
import 'package:bill_hub/app/model/invoice_item.dart';
import 'package:bill_hub/app/modules/buyer/home/buyer_cubit/states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../model/complaint.dart';

class BuyerCubit extends Cubit<BuyerStates> {
  BuyerCubit() : super(buyerIntiState());

  static BuyerCubit getCubit(context) => BlocProvider.of(context);



  Buyer? buyerModel;
  void getBuyerData(String uid) {
    emit(GetBuyerLoadingState());
    FirebaseFirestore.instance
        .collection('Buyer')
        .doc(uid)
        .get()
        .then((value) {
      buyerModel = Buyer.fromMap(value.data()!);
      print(buyerModel!.email);
      emit(GetBuyerSuccessState());
    }).catchError((e) {
      emit(GetBuyerErrorState());
    });
  }

  AddComplaint({
    required String title,
    required String description,
    required String date,
  }) async {
    emit(AddComplaintLoadingState());
    String complaintId = await generateRandomString(25);
    Complaint complaint = Complaint(complaintId, title, buyerModel!.name,
        'Buyer', description, false, '', date, buyerModel!.uid);
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

  List<Complaint> allBuyerComplaint = [];
  GetBuyerComplaint() {
    allBuyerComplaint = [];
    emit(GetComplaintLoadingState());
    FirebaseFirestore.instance
        .collection('All Complaints')
        .where('userId', isEqualTo: buyerModel!.uid)
        .get()
        .then((value) {
      for (var element in value.docs) {
        allBuyerComplaint.add(Complaint.fromMap(element.data()));
      }
      print(allBuyerComplaint.length);
      emit(GetComplaintSuccessState());
    }).catchError((e) {
      emit(GetComplaintErrorState());
    });
  }

  List<InvoiceItem> allBuyerInvoices = [];
  List<InvoiceItem> allBuyerPaidInvoices = [];
  GetAllBuyerInvoice() {
    allBuyerInvoices = [];
    allBuyerPaidInvoices=[];
    emit(GetAllInvoiceLoadingState());
    FirebaseFirestore.instance
        .collection('All Invoices')
        .where('buyerPhone', isEqualTo: buyerModel!.phone)
        .get()
        .then((value) {
      for (var element in value.docs) {
        if(InvoiceItem.fromMap(element.data()).isPaid!){
          allBuyerPaidInvoices.add(InvoiceItem.fromMap(element.data()));
        }else{
          print('=========================================');
          allBuyerInvoices.add(InvoiceItem.fromMap(element.data()));
        }
      }
      emit(GetAllInvoiceSuccessState());
    }).catchError((e) {
      emit(GetAllInvoiceErrorState());
    });
  }

  List<InvoiceItem> searchList=[];
  List<InvoiceItem> searchPaidList=[];
  void search(String value){
    searchList = allBuyerInvoices.where((element) {
      String number = element.invoiceNumber!.toLowerCase();
      return number.contains(value.toLowerCase());
    }).toList();
    searchPaidList = allBuyerPaidInvoices.where((element) {
      String number = element.invoiceNumber!.toLowerCase();
      return number.contains(value.toLowerCase());
    }).toList();
    emit(ChangeSearchListState());
  }



  String generateRandomString(int len) {
    var r = Random();
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)])
        .join();
  }
}
