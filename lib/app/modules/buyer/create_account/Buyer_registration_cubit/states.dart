abstract class RegisterBuyerStates{}

class InitStates extends RegisterBuyerStates{}

class CreateBuyerLoadingState extends RegisterBuyerStates{}
class CreateBuyerSuccessState extends RegisterBuyerStates{
  String id;
  CreateBuyerSuccessState(this.id);
}
class CreateBuyerErrorState extends RegisterBuyerStates{}

