class Product {
  String? productId;
  String? name;
  double? price;
  int? amount;
  bool? hide;

  Product(this.productId,this.name, this.price, this.amount,this.hide);

  Product.fromMap(Map<String,dynamic> map){
    name = map['name'];
    price = map['price'];
    amount = map['amount'];
    productId = map['productId'];
    hide = map['hide'];
  }

  Map<String,dynamic>? toMap(){
    return {
      'name':name,
      'price':price,
      'amount':amount,
      'productId':productId,
      'hide':hide,
    };
  }
}