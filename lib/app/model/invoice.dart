import 'package:bill_hub/app/model/product.dart';
import 'package:bill_hub/app/model/vendor.dart';

import 'buyer.dart';

class Invoice {
  String? invoiceNumber;
  String? invoiceId;
  String? creationDate;
  String? endDate;
  Buyer? buyer;
  Vendor? vendor;
  List<Product>? product;

  Invoice(this.invoiceNumber, this.invoiceId, this.creationDate, this.endDate,
      this.buyer, this.vendor, this.product);
}