import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

class CartItemDisplay extends StatelessWidget {
  final CartItem cartItem;
  final String cartItemKey;

  CartItemDisplay({
    required this.cartItem,
    required this.cartItemKey,
  });

  @override
  Widget build(BuildContext context) {
    final Cart cart = Provider.of<Cart>(context, listen: false);

    return Dismissible(
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Are you sure you wish to delete ${cartItem.title}?'),
            content: Text("This action cannot be undone"),
            actions: [
              TextButton(
                child: Text(
                  "Yes",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
              TextButton(
                child: Text(
                  "No",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
            ],
          ),
        );
      },
      direction: DismissDirection.endToStart,
      key: ValueKey(cartItem.id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
      ),
      onDismissed: (direction) {
        cart.removeItem(cartItemKey);
      },
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text('\$${cartItem.price}'),
                ),
              ),
            ),
            title: Text(cartItem.title),
            subtitle: Text(
                'Total: \$${(cartItem.price * cartItem.quantity).toStringAsFixed(2)}'),
            trailing: Text('${cartItem.quantity} x'),
          ),
        ),
      ),
    );
  }
}
