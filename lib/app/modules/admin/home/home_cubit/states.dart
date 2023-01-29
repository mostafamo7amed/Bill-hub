
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

class GetComplaintLoadingState extends AdminStates{}
class GetComplaintSuccessState extends AdminStates{}
class GetComplaintErrorState extends AdminStates{}

class UpdateComplaintLoadingState extends AdminStates{}
class UpdateComplaintSuccessState extends AdminStates{}
class UpdateComplaintErrorState extends AdminStates{}

class GetAllInvoiceLoadingState extends AdminStates{}
class GetAllInvoiceSuccessState extends AdminStates{}
class GetAllInvoiceErrorState extends AdminStates{}

class ChangeSearchListState extends AdminStates{}
