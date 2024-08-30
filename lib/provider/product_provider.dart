import 'package:ecom_boni_user/db/firestore_helper.dart';
import 'package:ecom_boni_user/models/product_model.dart';
import 'package:flutter/foundation.dart';

class ProductProvider extends ChangeNotifier {
  List<ProductModel> productList = [];
  void getAllProducts() => FirestoreHelper.getAllProducts().listen((snapshort) {
        productList = List.generate(snapshort.docs.length,
            (index) => ProductModel.fromMap(snapshort.docs[index].data()));
        notifyListeners();
      });
}
