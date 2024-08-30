import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom_boni_user/auth/firebase_auth_service.dart';
import 'package:ecom_boni_user/models/order_model.dart';
import 'package:ecom_boni_user/pages/order_success_page.dart';
import 'package:ecom_boni_user/pages/product_list_page.dart';
import 'package:ecom_boni_user/provider/cart_provider.dart';
import 'package:ecom_boni_user/provider/order_provider.dart';
import 'package:ecom_boni_user/utils/contants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderConfirmationPage extends StatefulWidget {
  const OrderConfirmationPage({super.key});
  static const String routeName = '/order_page';

  @override
  State<OrderConfirmationPage> createState() => _OrderConfirmationPageState();
}

class _OrderConfirmationPageState extends State<OrderConfirmationPage> {
  late CartProvider _cartProvider;
  late OrderProvider _orderProvider;
  late String _customerId;
  bool isInit = true;
  bool isLoding = true;
  String _paymentRadioGroupValue = PaymentMethod.cod;
  @override
  void didChangeDependencies() {
    _cartProvider = Provider.of<CartProvider>(context);
    _orderProvider = Provider.of<OrderProvider>(context);
    _customerId = ModalRoute.of(context)!.settings.arguments as String;
    if (isInit) {
      _orderProvider.getOrderConstants().then((_) {
        setState(() {
          isLoding = false;
        });
      });
      isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Confirm Order')),
      body: isLoding
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  _buildInvoice(),
                  _buildPaymentSelectScetion(),
                  ElevatedButton(
                      onPressed: () {
                        _placeOrder();
                      },
                      child: const Text('PLACE ORDER')),
                ],
              ),
            ),
    );
  }

  Widget _buildInvoice() {
    return Card(
      margin: const EdgeInsets.all(10.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: _cartProvider.cartList
                  .map((model) => ListTile(
                        title: Text(
                          model.productName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text('${model.price} * ${model.qty}'),
                        trailing: Text(
                          '$takaSymbol${_cartProvider.getPriceWithQty(model)}',
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ))
                  .toList(),
            ),
            const Divider(
              height: 2,
              color: Colors.grey,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    '$takaSymbol${_cartProvider.cartItemsTotalPrice}',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'After Discount(${_orderProvider.orderConstantsModel.discount}%)',
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text(
                    '$takaSymbol${_orderProvider.getPriceAfterDiscount(_cartProvider.cartItemsTotalPrice)}',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Vat(${_orderProvider.orderConstantsModel.vat}%)',
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text(
                    '$takaSymbol${_orderProvider.getTotalVatAmount(_cartProvider.cartItemsTotalPrice)}',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Delivery Charge',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    '$takaSymbol ${_orderProvider.orderConstantsModel.deliveryCharge}',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const Divider(
              color: Colors.grey,
              height: 2,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Grand Total:',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '$takaSymbol${_orderProvider.getGrandTotal(_cartProvider.cartItemsTotalPrice)}',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentSelectScetion() {
    return Column(
      children: [
        ListTile(
          title: Text(
            PaymentMethod.cod,
            style: const TextStyle(
              fontSize: 18,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          leading: Radio<String>(
              value: PaymentMethod.cod,
              groupValue: _paymentRadioGroupValue,
              onChanged: (value) {
                setState(() {
                  _paymentRadioGroupValue = value!;
                });
              }),
        ),
        ListTile(
          title: Text(
            PaymentMethod.online,
            style: const TextStyle(
              fontSize: 18,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          leading: Radio<String>(
              value: PaymentMethod.online,
              groupValue: _paymentRadioGroupValue,
              onChanged: (value) {
                setState(() {
                  _paymentRadioGroupValue = value!;
                });
              }),
        ),
      ],
    );
  }

  void _placeOrder() {
    final orderModel = OrderModel(
      customerId: _customerId,
      userId: FirebaseAuthService.currentUser!.uid,
      paymentMethod: _paymentRadioGroupValue,
      orderStatus: OrderStatus.pending,
      vat: _orderProvider.orderConstantsModel.vat,
      discount: _orderProvider.orderConstantsModel.discount,
      deliveryCharge: _orderProvider.orderConstantsModel.deliveryCharge,
      grandTotal:
          _orderProvider.getGrandTotal(_cartProvider.cartItemsTotalPrice),
      timestamp: Timestamp.fromDate(DateTime.now()),
    );
    _orderProvider
        .addNewOrder(orderModel, _cartProvider.cartList)
        .then((value) {
      _cartProvider.clearCart();
      Navigator.pushNamedAndRemoveUntil(context, OrderSuccessPage.routeName,
          ModalRoute.withName(ProductListPage.routeName));
    }).catchError((error) {});
  }
}
