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
    if (ModalRoute.of(context)!.settings.arguments != null) {
      editingProduct = ModalRoute.of(context)!.settings.arguments as Product;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(editingProduct!=null? "Editing ${editingProduct.title}" : "New Product"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: ListView(
            children: [
              TextFormField(decoration: InputDecoration(labelText: "Title"), textInputAction: TextInputAction.next, initialValue: editingProduct!=null?editingProduct.title:null,),
            ],
          ),
        ),
      ),
    );
  }
}
