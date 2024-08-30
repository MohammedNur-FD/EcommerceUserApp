import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  String? orderId;
  Timestamp? timestamp;
  String? customerId;
  String? userId;
  num? grandTotal;
  int? discount;
  int? deliveryCharge;
  int? vat;
  String? orderStatus;
  String? paymentMethod;
  OrderModel({
    this.orderId,
    this.timestamp,
    this.customerId,
    this.userId,
    this.grandTotal,
    this.discount,
    this.deliveryCharge,
    this.orderStatus,
    this.vat,
    this.paymentMethod,
  });
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'customerId': customerId,
      'userId': userId,
      'orderId': orderId,
      'discount': discount,
      'vat': vat,
      'deviveryCharge': deliveryCharge,
      'paymentMethod': paymentMethod,
      'orderStatus': orderStatus,
      'timestamp': timestamp,
      'grandTotal': grandTotal,
    };
    return map;
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) => OrderModel(
        customerId: map['customerId'],
        userId: map['userId'],
        discount: map['discount'],
        orderId: map['orderId'],
        vat: map['vat'],
        deliveryCharge: map['deliveryCharge'],
        paymentMethod: map['paymentMethod'],
        orderStatus: map['orderStatus'],
        timestamp: map['timestamp'],
        grandTotal: map['grandTotal'],
      );
  @override
  String toString() {
    return 'OrderModel{customerId=$customerId,userId=$userId,discount=$discount,orderId=$orderId,vat=$vat,deliveryCharge=$deliveryCharge,paymentMethod=$paymentMethod,orderStatus=$orderStatus,timestamp=$timestamp,grandTotal=$grandTotal}';
  }
}
