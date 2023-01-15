
abstract class LoginStates {}

class SocialInitState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  String uid;
  LoginSuccessState(this.uid);
}
class LoginSuccessErrorState extends LoginStates {
}
class LoginLoadingState extends LoginStates {}
class LoginErrorState extends LoginStates {}

class LoginPasswordState extends LoginStates {}
class LoginNavigateState extends LoginStates {}