class Product {
  String? name;
  double? price;
  int? amount;

  Product(this.name, this.price, this.amount);

  Product.fromMap(Map<String,dynamic> map){
    name = map['name'];
    price = map['price'];
    amount = map['amount'];
  }

  Map<String,dynamic>? toMap(){
    return {
      'name':name,
      'price':price,
      'amount':amount,
    };
  }
}