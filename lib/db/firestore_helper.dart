import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom_boni_user/models/cart_model.dart';
import 'package:ecom_boni_user/models/customer_model.dart';
import 'package:ecom_boni_user/models/order_model.dart';

class FirestoreHelper {
  // ignore: unused_field
  static const String _collectionProduct = 'Products';
  static const String _collectionCategory = 'Categories';
  static const String _collectionCustomer = 'Customers';
  static const String _collectionConstants = 'Constants';
  static const String _collectionOrders = 'Orders';
  static const String _collectionOrderDetails = 'OrderDetails';
  static const String _documentOrderConstants = 'OrderConstants';

  // ignore: unused_field
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllCategorise() =>
      _db.collection(_collectionCategory).orderBy('name').snapshots();

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllProducts() => _db
      .collection(_collectionProduct)
      .where('isAvailable', isEqualTo: true)
      .snapshots();

  static Stream<QuerySnapshot<Map<String, dynamic>>> getOrdersBuUser(
          String userId) =>
      _db
          .collection(_collectionOrders)
          .where('userId', isEqualTo: userId)
          .snapshots();

  static Stream<DocumentSnapshot<Map<String, dynamic>>> getOrderConstants() =>
      _db
          .collection(_collectionConstants)
          .doc(_documentOrderConstants)
          .snapshots();

  static void deleteCategory() {
    _db.collection(_collectionCategory).doc().delete();
  }

  static Future<QuerySnapshot<Map<String, dynamic>>> findCustomerByPhone(
      String phone) {
    return _db
        .collection(_collectionCustomer)
        .where('customerPhone', isEqualTo: phone)
        .get();
  }

  static Future<String> addNewCustomer(CustomerModel customerModel) async {
    final docRef = _db.collection(_collectionCustomer).doc();
    customerModel.customerId = docRef.id;
    await docRef.set(customerModel.toMap());
    return docRef.id;
  }

  static Future<void> updateCustomer(CustomerModel customerModel) {
    final docRef =
        _db.collection(_collectionCustomer).doc(customerModel.customerId);
    customerModel.customerId = docRef.id;
    return docRef.update(customerModel.toMap());
  }

  static Future<void> addNewOrder(
      OrderModel orderModel, List<CartModel> cartList) {
    final writeBatch = _db.batch();
    final orderDoc = _db.collection(_collectionOrders).doc();
    orderModel.orderId = orderDoc.id;
    writeBatch.set(orderDoc, orderModel.toMap());
    // ignore: unused_local_variable
    for (var cartModel in cartList) {
      final detailsDoc = _db
          .collection(_collectionOrders)
          .doc(orderDoc.id)
          .collection(_collectionOrderDetails)
          .doc();
      writeBatch.set(detailsDoc, cartModel.toMap());
    }
    return writeBatch.commit();
  }
}
