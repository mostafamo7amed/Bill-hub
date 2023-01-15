abstract class RegisterVendorStates{}

class InitStates extends RegisterVendorStates{}

class ChangeDropDownState extends RegisterVendorStates{}
class ChangeCompanyDropDownState extends RegisterVendorStates{}

class ChangeCompanyListState extends RegisterVendorStates{}

class CreateVendorLoadingState extends RegisterVendorStates{}
class CreateVendorSuccessState extends RegisterVendorStates{
  String id;
  CreateVendorSuccessState(this.id);
}
class CreateVendorErrorState extends RegisterVendorStates{}

