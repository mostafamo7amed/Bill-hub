import 'package:bill_hub/app/model/vendor.dart';
import 'package:bill_hub/app/modules/admin/home/home_cubit/states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../shared/network/local/cache_helper.dart';
import '../../../../model/admin.dart';


class AdminCubit extends Cubit<AdminStates> {
  AdminCubit() : super(AdminInitState());

  static AdminCubit getCubit(context) => BlocProvider.of(context);



  Admin? adminModel;
  void getUser() {
    String uid = CacheHelper.getData(key: 'uid');
    emit(GetUserLoadingState());
    FirebaseFirestore.instance.collection('admin').doc(uid).get().then((value) {
      adminModel = Admin.fromMap(value.data()!);
      print(adminModel!.email);
      emit(GetUserSuccessState());
    }).catchError((e) {
      emit(GetUserErrorState());
    });
  }


  List<Vendor> vendorListModel =[];


  void getVendor() {
    vendorListModel =[];
    emit(GetVendorLoadingState());
    FirebaseFirestore.instance.collection('Vendor').where('isBlocked',isEqualTo: true).get().then((value) {
      for (var element in value.docs) {
        vendorListModel.add(Vendor.fromMap(element.data()));
      }
      emit(GetVendorSuccessState());
    }).catchError((e) {
      emit(GetVendorErrorState());
    });
  }


  void RejectUser({
    required bool isBlocked,
    required int index,
    required String blockReason,
  }) {
     Vendor vendor =Vendor(
         vendorListModel[index].uid,
         vendorListModel[index].name,
         vendorListModel[index].email,
         vendorListModel[index].phone,
         vendorListModel[index].companyName,
         vendorListModel[index].companyType,
         vendorListModel[index].employment, isBlocked, blockReason);
      FirebaseFirestore.instance
          .collection('Vendor')
          .doc(vendorListModel[index].uid)
          .update(vendor.toMap()!)
          .then((value) {
        emit(ChangeUserStatusSuccessState());
      }).catchError((e) {
        emit(ChangeUserStatusErrorState());
      });

  }

  removeVendor(index) {
    vendorListModel.removeAt(index);
    emit(RemoveVendorState());
  }

}
