
import 'package:flutter/material.dart';

import '../providers/product.dart';

class EditProductScreen extends StatefulWidget {
  static const String routeName = "/edit_product_screen";

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {


  @override
  Widget build(BuildContext context) {
    Product? editingProduct;
    if (ModalRoute.of(context)!.settings.arguments!=null) {
      editingProduct = ModalRoute
          .of(context)!
          .settings
          .arguments as Product;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
      ),
      body: Text(editingProduct != null? editingProduct.title:"New Item"),
    );
  }
}
