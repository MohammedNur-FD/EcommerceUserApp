import 'package:ecom_boni_user/pages/customer_info_page.dart';
import 'package:ecom_boni_user/provider/cart_provider.dart';
import 'package:ecom_boni_user/utils/contants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  static const String routeName = '/cart_page';

  const CartPage({super.key});
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Cart',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Consumer<CartProvider>(
              builder: (context, provider, _) => IconButton(
                  onPressed: () {
                    provider.clearCart();
                  },
                  icon: const Icon(Icons.cancel_outlined)))
        ],
      ),
      body: Consumer<CartProvider>(builder: (context, provider, _) {
        return Column(children: [
          Expanded(
            child: provider.totalItemInCart == 0
                ? const Center(
                    child: Text(
                    'Cart is empty!',
                    style: TextStyle(fontSize: 20),
                  ))
                : ListView.builder(
                    itemCount: provider.cartList.length,
                    itemBuilder: (context, index) {
                      final cartModel = provider.cartList[index];
                      return ListTile(
                        title: Text(
                          cartModel.productName,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w900),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Quantity:${cartModel.qty}'),
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      provider.dicreaseQty(cartModel);
                                    },
                                    icon: const Icon(Icons.remove)),
                                const Text('Qty'),
                                IconButton(
                                    onPressed: () {
                                      provider.increaseQty(cartModel);
                                    },
                                    icon: const Icon(Icons.add)),
                              ],
                            ),
                          ],
                        ),
                        trailing: Text(
                          '$takaSymbol ${provider.getPriceWithQty(cartModel)}',
                          style: const TextStyle(fontSize: 20),
                        ),
                      );
                    }),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            width: double.maxFinite,
            height: 80,
            color: const Color.fromARGB(255, 99, 108, 163),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total: $takaSymbol${provider.cartItemsTotalPrice.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (provider.totalItemInCart > 0)
                  TextButton(
                      onPressed: () => Navigator.pushNamed(
                          context, CustomerInfoPage.routeName),
                      child: const Text(
                        'Checkout',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ))
              ],
            ),
          ),
        ]);
      }),
    );
  }
}
