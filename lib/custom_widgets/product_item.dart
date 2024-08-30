import 'package:ecom_boni_user/models/product_model.dart';
import 'package:ecom_boni_user/provider/cart_provider.dart';
import 'package:ecom_boni_user/utils/contants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatefulWidget {
  final ProductModel productModel;
  const ProductItem(this.productModel, {super.key});

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 7,
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16)),
                child: FadeInImage.assetNetwork(
                    fadeInDuration: const Duration(seconds: 3),
                    width: double.maxFinite,
                    fit: BoxFit.cover,
                    fadeInCurve: Curves.bounceInOut,
                    placeholder: 'images/placeholder.jpg',
                    image: widget.productModel.downlodeImageUrl!),
              ),
            ),
            ListTile(
              title: Text(widget.productModel.name!),
              trailing: Text('Stock ${widget.productModel.stock}'),
            ),
            Text(
              '$takaSymbol${widget.productModel.price}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Consumer<CartProvider>(
              builder: (context, provider, _) => ElevatedButton(
                child: Text(provider.isInCart(widget.productModel.id!)
                    ? 'REMOVE'
                    : 'ADD'),
                onPressed: () {
                  if (provider.isInCart(widget.productModel.id!)) {
                    provider.removeFromCart(widget.productModel.id!);
                  } else {
                    provider.addToCart(widget.productModel);
                  }
                },
              ),
            ),
          ],
        ));
  }
}
