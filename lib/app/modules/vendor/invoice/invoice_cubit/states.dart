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
class InvoiceCalculateAmountState extends InvoiceStates{}