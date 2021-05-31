import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../providers/products.dart';
import '../providers/cart.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = "/productDetail";

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute
        .of(context)!
        .settings
        .arguments as String;
    final loadedProduct =
    Provider.of<Products>(context, listen: false).findById(productId);
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(),
                ),
              ),
              width: double.infinity,
              height: 300,
              child: Image.network(
                loadedProduct.imageUrl,
                fit: BoxFit.fitWidth,
              ),
            ),
            SizedBox(height: 10),
            Text('\$${loadedProduct.price.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 40),),
            SizedBox(height: 10),
            Text(
              loadedProduct.title,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(loadedProduct.description, softWrap: true,),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                cart.addItem(loadedProduct.id, loadedProduct.price, loadedProduct.title);
                Navigator.of(context).pop();
              },
              child: Text("Add one to cart"),
            ),
          ],
        ),
      ),
    );
  }
}
