import 'package:bill_hub/app/model/buyer.dart';
import 'package:bill_hub/app/modules/buyer/create_account/Buyer_registration_cubit/states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterBuyerCubit extends Cubit<RegisterBuyerStates> {
  RegisterBuyerCubit() : super(InitStates());

  static RegisterBuyerCubit getCubit(context) => BlocProvider.of(context);


  void createBuyerAccount({
    required String userType,
    required String email,
    required String name,
    required String phone,
    required String id,
  }) {
    emit(CreateBuyerLoadingState());
    Buyer buyerModel = Buyer(id, name, email, phone);
      FirebaseFirestore.instance
          .collection(userType)
          .doc(id)
          .set(buyerModel.toMap()!)
          .then((value) {
        emit(CreateBuyerSuccessState(id));
      }).catchError((e) {
        emit(CreateBuyerErrorState());
      });
  }
}
