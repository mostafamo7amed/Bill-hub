abstract class ChatStates{}

class ChatIntiSate extends ChatStates{}


class ChatSendMessageSuccessState extends ChatStates {}
class ChatSendMessageErrorState extends ChatStates {}

class ChatGetMessageSuccessState extends ChatStates {}
class ChatGetMessageErrorState extends ChatStates {}

class ChatGetAllUsersLoadingState extends ChatStates{}
class ChatGetAllVendorsSuccessState extends ChatStates{}
class ChatGetAllBuyerSuccessState extends ChatStates{}
class ChatGetAllUsersErrorState extends ChatStates{}

class ChatGetAllVendorChatSuccessState extends ChatStates{}
class ChatGetAllVendorChatErrorState extends ChatStates{}