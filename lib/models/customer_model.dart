class CustomerModel {
  String? customerName;
  String? customerId;
  String? customerPhone;
  String? customerEmail;
  String? customerAddress;
  CustomerModel(
      {this.customerName,
      this.customerId,
      this.customerPhone,
      this.customerEmail,
      this.customerAddress});
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'customerName': customerName,
      'customerId': customerId,
      'customerPhone': customerPhone,
      'customerEmail': customerEmail,
      'customerAddress': customerAddress,
    };
    return map;
  }

  factory CustomerModel.fromMap(Map<String, dynamic> map) => CustomerModel(
        customerName: map['customerName'],
        customerId: map['customerId'],
        customerPhone: map['customerPhone'],
        customerEmail: map['customerEmail'],
        customerAddress: map['customerAddress'],
      );
  @override
  String toString() {
    return 'CustomerModel{customerName:$customerName,customerId:$customerId,customerPhone:$customerPhone,customerEmail:$customerEmail,customerAddress:$customerAddress}';
  }
}
