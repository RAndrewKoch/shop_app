import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/edit_product_screen.dart';

import '../providers/product.dart';
import '../providers/products.dart';

class UserProductItem extends StatelessWidget {
  final Product product;

  UserProductItem({required this.product});

  @override
  Widget build(BuildContext context) {
    final productsList = Provider.of<Products>(context);

    return Card(
      clipBehavior: Clip.hardEdge,
      child: ListTile(
        leading: Container(
          width: MediaQuery.of(context).size.width * .15,
          child: CircleAvatar(
            backgroundImage: NetworkImage(product.imageUrl!),
          ),
        ),
        title: Text("${product.title}"),
        subtitle: Text(
            "${product.description}-\$${product.price!.toStringAsFixed(2)}"),
        trailing: Container(
          width: MediaQuery.of(context).size.width * .25,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {Navigator.pushNamed(context, EditProductScreen.routeName, arguments: product);},
                icon: Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: Text("Are you sure?"),
                      content: Text(
                          "Product will be removed from your listings, but will not remove any previously ordered units of this item from alredy sent orders."),
                      actions: [
                        TextButton(
                          child: Text(
                            "Yes",
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () => Navigator.of(context).pop(true),
                        ),
                        TextButton(
                          child: Text(
                            "No",
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () => Navigator.of(context).pop(false),
                        ),
                      ],
                    ),
                  ).then((result) {
                    if (result) {
                      productsList.removeProduct(product);
                    } else {
                      return;
                    }
                  });
                },
                icon: Icon(Icons.delete),
                color: Theme.of(context).errorColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
