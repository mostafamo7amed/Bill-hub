
abstract class AdminStates {}

class AdminInitState extends AdminStates {}

class GetUserLoadingState extends AdminStates{}
class GetUserSuccessState extends AdminStates{}
class GetUserErrorState extends AdminStates{}

class GetVendorLoadingState extends AdminStates{}
class GetVendorSuccessState extends AdminStates{}
class GetVendorErrorState extends AdminStates{}

class ChangeUserStatusSuccessState extends AdminStates{}
class ChangeUserStatusErrorState extends AdminStates{}

class RemoveVendorState extends AdminStates{}