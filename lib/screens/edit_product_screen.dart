import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';

import '../providers/product.dart';

class EditProductScreen extends StatefulWidget {
  static const String routeName = "/edit_product_screen";


  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _urlController = TextEditingController();
  final _urlFocusNode = FocusNode();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  Product editingProduct = Product(id: "", title: "", description: "", price: 0, imageUrl: "",);

  @override
  void initState() {
    _urlFocusNode.addListener(updateImageUrl);
    super.initState();
  }

  void dispose() {
    _urlController.dispose();
    _urlFocusNode.removeListener(updateImageUrl);
    _urlFocusNode.dispose();

    super.dispose();
  }

  void updateImageUrl() {
    if (!_urlFocusNode.hasFocus) {
      print ("update url fired");
      setState(() {

      });
    }
  }

  void _saveForm() {
    final isValid = _form.currentState!.validate();
    if (isValid) {
      _form.currentState!.save();
      print(editingProduct.title);
      Provider.of<Products>(context, listen: false).addProduct(editingProduct);
      Navigator.of(context).pop();
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Product"),
        actions: [
          IconButton(
            onPressed: () => _saveForm(),
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  labelText: "Title",
                ),
                textInputAction: TextInputAction.next,
                initialValue: editingProduct.title,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter a value";
                  }
                  return null;
                },
                onSaved: (value) {
                  editingProduct = Product(
                    title: value,
                    price: editingProduct.price,
                    id: editingProduct.id,
                    description: editingProduct.description,
                    imageUrl: editingProduct.imageUrl,
                  );
                },
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(labelText: "Price"),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                initialValue: editingProduct.price!.toStringAsFixed(2),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter a value";
                  } else if (double.tryParse(value) == null) {
                    return "Price must be a number";
                  } else if (double.parse(value) <= 0) {
                    return "Price cannot be zero or less";
                  }
                  return null;
                },
                onSaved: (value) {
                  editingProduct = Product(
                    title: editingProduct.title,
                    price: double.parse(value!),
                    id: editingProduct.id,
                    description: editingProduct.description,
                    imageUrl: editingProduct.imageUrl,
                  );
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Description"),
                maxLines: 3,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter a description";
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
                initialValue: editingProduct.description,
                onSaved: (value) {
                  editingProduct = Product(
                    title: editingProduct.title,
                    price: editingProduct.price,
                    id: editingProduct.id,
                    description: value,
                    imageUrl: editingProduct.imageUrl,
                  );
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
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
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value!.isEmpty){
                          return "Please enter a URL";
                        } else if(!value.startsWith("http") && !value.startsWith("https")){
                          return "Please enter a valid url starting with \"http\" or \"https\"";
                        } else if (!value.endsWith(".jpg")&&!value.endsWith(".jpeg")&&!value.endsWith(".png")){
                          return "Image url must end with .jpg, .jpeg, or .png";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Image URL",
                      ),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.next,
                      controller: _urlController,
                      // onEditingComplete: () => updateImageUrl,
                      focusNode: _urlFocusNode,
                      onFieldSubmitted: (_) => _saveForm(),
                      onSaved: (value) {
                        editingProduct = Product(
                          title: editingProduct.title,
                          price: editingProduct.price,
                          id: editingProduct.id,
                          description: editingProduct.description,
                          imageUrl: value,
                        );
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
