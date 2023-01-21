class InvoiceItem{
  String? invoiceNumber;
  String? invoiceId;
  String? creationDate;
  String? endDate;
  String? vendorId;
  String? fileUrl;
  String? buyerName;
  String? buyerPhone;
  bool? isPaid;

  InvoiceItem(
      this.invoiceNumber,
      this.invoiceId,
      this.creationDate,
      this.endDate,
      this.vendorId,
      this.fileUrl,
      this.buyerName,
      this.buyerPhone,
      this.isPaid,
      );

  InvoiceItem.fromMap(Map<String,dynamic> map){
    invoiceNumber = map['invoiceNumber'];
    invoiceId = map['invoiceId'];
    creationDate = map['creationDate'];
    endDate = map['endDate'];
    vendorId = map['vendorId'];
    fileUrl = map['fileUrl'];
    buyerName = map['buyerName'];
    buyerPhone = map['buyerPhone'];
    isPaid = map['isPaid'];
  }

  Map<String,dynamic>? toMap() {
    return {
      'invoiceNumber': invoiceNumber,
      'invoiceId': invoiceId,
      'creationDate': creationDate,
      'endDate': endDate,
      'vendorId': vendorId,
      'fileUrl': fileUrl,
      'buyerName': buyerName,
      'buyerPhone': buyerPhone,
      'isPaid': isPaid,
    };
  }
}