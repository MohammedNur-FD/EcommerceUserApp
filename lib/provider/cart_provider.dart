import 'package:ecom_boni_user/models/cart_model.dart';
import 'package:ecom_boni_user/models/product_model.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  List<CartModel> cartList = [];
  void addToCart(ProductModel productModel) {
    cartList.add(
      CartModel(
          productId: productModel.id!,
          productName: productModel.name!,
          price: productModel.price!),
    );
    notifyListeners();
  }

  void removeFromCart(String id) {
    final cartModel =
        cartList.firstWhere((cartModel) => cartModel.productId == id);
    cartList.remove(cartModel);
    notifyListeners();
  }

  void clearCart() {
    cartList.clear();
    notifyListeners();
  }

  bool isInCart(String id) {
    bool tag = false;
    for (var c in cartList) {
      if (c.productId == id) {
        tag = true;
        break;
      }
    }
    return tag;
  }

  int get totalItemInCart => cartList.length;
  num getPriceWithQty(CartModel cartModel) => cartModel.price * cartModel.qty;
  void increaseQty(CartModel cartModel) {
    var index = cartList.indexOf(cartModel);
    cartList[index].qty += 1;
    notifyListeners();
  }

  void dicreaseQty(CartModel cartModel) {
    var index = cartList.indexOf(cartModel);
    if (cartList[index].qty > 1) {
      cartList[index].qty -= 1;
    }
    notifyListeners();
  }

  num get cartItemsTotalPrice {
    num total = 0;
    for (var product in cartList) {
      total += product.price * product.qty;
    }
    return total;
  }
}
