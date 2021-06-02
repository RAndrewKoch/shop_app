import 'package:flutter/material.dart';

import '../providers/product.dart';

class EditProductScreen extends StatefulWidget {
  static const String routeName = "/edit_product_screen";

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _urlController = TextEditingController();

  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Product? editingProduct;
    if (ModalRoute.of(context)!.settings.arguments != null) {
      editingProduct = ModalRoute.of(context)!.settings.arguments as Product;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(editingProduct != null
            ? "Editing ${editingProduct.title}"
            : "New Product"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "Title"),
                textInputAction: TextInputAction.next,
                initialValue:
                    editingProduct != null ? editingProduct.title : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Price"),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                initialValue: editingProduct != null
                    ? editingProduct.price.toStringAsFixed(2)
                    : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Description"),
                maxLines: 3,
                textInputAction: TextInputAction.next,
                initialValue:
                    editingProduct != null ? editingProduct.description : null,
              ),
              Row(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(
                      top: 8,
                      right: 10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.grey,
                      ),
                    ),
                    child: _urlController.text.isEmpty
                        ? Text('Enter a URL')
                        : FittedBox(
                            child: Image.network(
                              _urlController.text,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: "Image URL",
                      ),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _urlController,
                      onEditingComplete: () {
                        setState(() {

                        });
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
