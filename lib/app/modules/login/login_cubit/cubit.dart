import 'package:bill_hub/app/modules/admin/home/home_admin.dart';
import 'package:bill_hub/app/modules/login/login_cubit/states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/components/component.dart';
import '../../buyer/home/home_buyer_view.dart';
import '../../vendor/home/home_vendor_view.dart';


class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(SocialInitState());

  static LoginCubit getCubit(context) => BlocProvider.of(context);
  userLogin({
    required String email,
    required String password,
    required context,
  }) {
    emit(LoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      //findUserType(value.user!.uid, context);
      emit(LoginSuccessState(value.user!.uid));
    }).catchError((error) {
      emit(LoginErrorState());
      toast(message: error.toString(), data: ToastStates.error);
    });
  }

  bool isPassword = true;

  changePasswordVisibility() {
    isPassword = !isPassword;
    emit(LoginPasswordState());
  }


  findUser(String UID,context){
    FirebaseFirestore.instance.collection('admin').where('id',isEqualTo: UID).get().then((value) {
      print(value.docs.toString());
      if(value.docs.isNotEmpty){
        navigateAndFinish(context, AdminHomeView());
        emit(LoginNavigateState());
      }else{
        FirebaseFirestore.instance.collection('Vendor').where('id',isEqualTo: UID).get().then((value) {
          print(value.docs.toString());
          if(value.docs.isNotEmpty){
            navigateAndFinish(context, HomeVendorView());
            emit(LoginNavigateState());
          }else{
            FirebaseFirestore.instance.collection('Buyer').where('id',isEqualTo: UID).get().then((value) {
              print(value.docs.toString());
              if(value.docs.isNotEmpty){
                navigateAndFinish(context, HomeBuyerView());
                emit(LoginNavigateState());
              }
            }).catchError((e){

            });
          }
        }).catchError((e){

        });
      }
    }).catchError((e){

    });
  }

}
