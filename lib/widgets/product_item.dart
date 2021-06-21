import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../providers/cart.dart';
import '../providers/product.dart';
import '../screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    final Product product = Provider.of<Product>(context);
    final Cart cart = Provider.of<Cart>(context);
    final String? authToken = Provider.of<Auth>(context).token;
    final String? userId = Provider.of<Auth>(context, listen: false).userId;
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () => Navigator.of(context)
              .pushNamed(ProductDetailScreen.routeName, arguments: product.id),
          child: Hero(
            tag: product.id!,
            child: FadeInImage(
              placeholder: AssetImage('assets/images/product-placeholder.png'),
              image: NetworkImage(product.imageUrl!),
              fit: BoxFit.cover,
            ),
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Theme.of(context).accentColor.withOpacity(.75),
          leading: IconButton(
            onPressed: () => product
                .toggleFavoriteStatus(authToken!, userId)
                .catchError((error) {
              scaffold.removeCurrentSnackBar();
              scaffold.showSnackBar(
                SnackBar(
                  duration: Duration(seconds: 2),
                  content: Text(
                      "Cannot update favorites, check internet connection"),
                ),
              );
            }),
            icon: product.isFavorite
                ? Icon(
                    Icons.favorite,
                    color: Colors.red,
                  )
                : Icon(
                    Icons.favorite_border,
                    color: Colors.black,
                  ),
          ),
          trailing: IconButton(
            onPressed: () {
              cart.addItem(product.id!, product.price!, product.title!);
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "Added to cart!",
                  ),
                  duration: Duration(seconds: 3),
                  action: SnackBarAction(
                    label: "UNDO",
                    onPressed: () {
                      cart.removeSingleItem(product.id!);
                    },
                  ),
                ),
              );
            },
            icon: Icon(
              Icons.add_shopping_cart,
              color: Colors.black,
            ),
          ),
          title: Text(
            product.title!,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
