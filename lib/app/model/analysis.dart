class Sales{
  String? month;
  int? numOfSales;

  Sales(this.month, this.numOfSales);
  Sales.fromMap(Map<String,dynamic> map){
    month = map['month'];
    numOfSales = map['numOfSales'];
  }


  Map<String,dynamic>? toMap() {
    return {
      'month': month,
      'numOfSales': numOfSales,
    };
  }
}