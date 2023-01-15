
abstract class RegisterStates {}

class InitState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {
  String id;
  RegisterSuccessState(this.id);
}
class RegisterLoadingState extends RegisterStates {}
class RegisterErrorState extends RegisterStates {}

class RegisterPasswordState extends RegisterStates {}
class RegisterPassword2State extends RegisterStates {}