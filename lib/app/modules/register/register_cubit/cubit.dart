import 'package:bill_hub/app/modules/register/register_cubit/states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/components/component.dart';


class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(InitState());

  static RegisterCubit getCubit(context) => BlocProvider.of(context);

  register({
    required String email,
    required String password,
  }) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
          emit(RegisterSuccessState(value.user!.uid));
    }).catchError((error) {
      emit(RegisterErrorState());
      toast(message: error.toString(), data: ToastStates.error);
    });
  }

  bool isPassword = true;
  bool isPassword2 = true;

  changePasswordVisibility() {
    isPassword = !isPassword;
    emit(RegisterPasswordState());
  }
  changePassword2Visibility() {
    isPassword2 = !isPassword2;
    emit(RegisterPassword2State());
  }
}
