import 'package:bill_hub/app/modules/vendor/invoice/invoice_cubit/cubit.dart';

abstract class InvoiceStates {}

class InvoiceInitState extends InvoiceStates{}

class Invoice1State extends InvoiceStates{}
class Invoice2State extends InvoiceStates{}
class Invoice3State extends InvoiceStates{}

class InvoiceExpDateState extends InvoiceStates{}
class InvoiceCustomerDataState extends InvoiceStates{}
class InvoiceAddProductToListState extends InvoiceStates{}
class InvoiceRemoveProductToListState extends InvoiceStates{}
class InvoiceClearListState extends InvoiceStates{}

class InvoiceCalculateAmountState extends InvoiceStates{}

class UploadInvoiceLoadingState extends InvoiceStates{}
class UploadInvoiceSuccessState extends InvoiceStates{}
class UploadInvoiceErrorState extends InvoiceStates{}

class GetVendorLoadingState extends InvoiceStates{}
class GetVendorSuccessState extends InvoiceStates{}
class GetVendorErrorState extends InvoiceStates{}

class AddProductLoadingState extends InvoiceStates{}
class AddProductSuccessState extends InvoiceStates{}
class AddProductErrorState extends InvoiceStates{}

class GetProductLoadingState extends InvoiceStates{}
class GetProductSuccessState extends InvoiceStates{}
class GetProductErrorState extends InvoiceStates{}

class CreateInvoiceLoadingState extends InvoiceStates{}
class CreateInvoiceSuccessState extends InvoiceStates{}
class CreateInvoiceErrorState extends InvoiceStates{}

class EditProductLoadingState extends InvoiceStates{}
class EditProductSuccessState extends InvoiceStates{}
class EditProductErrorState extends InvoiceStates{}

class HideProductSuccessState extends InvoiceStates{}
class HideProductErrorState extends InvoiceStates{}

class GetAllInvoiceLoadingState extends InvoiceStates{}
class GetAllInvoiceSuccessState extends InvoiceStates{}
class GetAllInvoiceErrorState extends InvoiceStates{}

class AddComplaintLoadingState extends InvoiceStates{}
class AddComplaintSuccessState extends InvoiceStates{}
class AddComplaintErrorState extends InvoiceStates{}

class GetComplaintLoadingState extends InvoiceStates{}
class GetComplaintSuccessState extends InvoiceStates{}
class GetComplaintErrorState extends InvoiceStates{}

class GetProductPriceLoadingState extends InvoiceStates{}
class GetProductPriceSuccessState extends InvoiceStates{}

class SetAnalysisSuccessState extends InvoiceStates{}
class SetAnalysisErrorState extends InvoiceStates{}
class GetAnalysisErrorState extends InvoiceStates{}
class GetAnalysisSuccessState extends InvoiceStates{}
class UpdateAnalysisSuccessState extends InvoiceStates{}
class UpdateAnalysisErrorState extends InvoiceStates{}

class ChangeSearchListState extends InvoiceStates{}

class PayInvoiceLoadingState extends InvoiceStates{}
class PayInvoiceSuccessState extends InvoiceStates{}
class PayInvoiceErrorState extends InvoiceStates{}