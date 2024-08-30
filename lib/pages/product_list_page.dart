import 'package:ecom_boni_user/auth/firebase_auth_service.dart';
import 'package:ecom_boni_user/custom_widgets/main_drawer.dart';
import 'package:ecom_boni_user/custom_widgets/product_item.dart';
import 'package:ecom_boni_user/pages/cart_page.dart';
import 'package:ecom_boni_user/provider/cart_provider.dart';
import 'package:ecom_boni_user/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});
  static const String routeName = '/product_list';

  @override
  State<ProductListPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<ProductListPage> {
  late ProductProvider _productProvider;
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      _productProvider = Provider.of<ProductProvider>(context);
      _productProvider.getAllProducts();
      if (!FirebaseAuthService.isUserEmailVerified) {
        Future.delayed(Duration.zero, () {
          _showEmailVerificationAlertDilog();
        });
      }
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MainDrawer(
      ),
      appBar: AppBar(
        title: const Text('All Products'),
        actions: [
          Consumer<CartProvider>(builder: (context, provider, _) {
            return Stack(
              children: [
                IconButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, CartPage.routeName),
                    icon: const Icon(Icons.shopping_cart)),
                _productCartSection(provider),
              ],
            );
          }),
        ],
      ),
      body: _productProvider.productList.isEmpty
          ? const Center(
              child: Text(
                'No items found',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            )
          : _buildGridVeiwSection(),
    );
  }

  _buildGridVeiwSection() {
    return GridView.count(
      padding: const EdgeInsets.all(8.0),
      childAspectRatio: 0.6,
      mainAxisSpacing: 2,
      crossAxisSpacing: 2,
      crossAxisCount: 2,
      children: _productProvider.productList
          .map((product) => ProductItem(product))
          .toList(),
    );
  }

  _productCartSection(CartProvider provider) {
    return Container(
      alignment: Alignment.center,
      width: 24,
      height: 24,
      decoration: const BoxDecoration(
        color: Colors.blue,
        shape: BoxShape.circle,
      ),
      child: FittedBox(
        child: Text(
          '${provider.totalItemInCart}',
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void _showEmailVerificationAlertDilog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Email not verified',
          style: TextStyle(color: Colors.black),
        ),
        content: const Text(
            'Click the button below to send a verification mail to your email Address.'),
        actions: [
          ElevatedButton(
              onPressed: () {
                FirebaseAuthService.sendVerificationMail().then((value) {
                  Navigator.pop(context);
                });
              },
              child: const Text('Send Verification Mail'))
        ],
      ),
    );
  }
}
