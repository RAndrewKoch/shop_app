import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../providers/products.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = "/productDetail";

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final loadedProduct =
        Provider.of<Products>(context, listen: false).findById(productId);
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      // appBar: AppBar(
      //   title: Text(loadedProduct.title!),
      // ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(centerTitle: true,
              title: Text(loadedProduct.title!),
              background: Hero(
                      tag: loadedProduct.id!,
                      child: Image.network(
                        loadedProduct.imageUrl!,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(height: 10),
                Text(
                  '\$${loadedProduct.price!.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 40),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Text(
                  loadedProduct.title!,
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Text(
                  loadedProduct.description!,
                  softWrap: true,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    cart.addItem(loadedProduct.id!, loadedProduct.price!,
                        loadedProduct.title!);
                    Navigator.of(context).pop();
                  },
                  child: Text("Add one to cart"),
                ),
                SizedBox(
                  height: 800,
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
