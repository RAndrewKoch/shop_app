import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../providers/orders.dart';
import '../widgets/cart_item_display.dart';

class CartScreen extends StatefulWidget {
  static const routeName = "/cart";

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  var _orderButtonDisabled = false;
  var _loadingOrder = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Cart cart = Provider.of<Cart>(context);

    if (cart.items.isEmpty) {
      setState(() {
        _orderButtonDisabled = !_orderButtonDisabled;
      });
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("Your Cart"),
        ),
        body: Column(
          children: [
            Card(
              margin: EdgeInsets.all(15),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total",
                      style: TextStyle(fontSize: 20),
                    ),
                    Spacer(),
                    Chip(
                      label: Text(
                        '\$${cart.totalAmount.toStringAsFixed(2)}',
                        style: TextStyle(
                            color: Theme.of(context)
                                .primaryTextTheme
                                .headline6!
                                .color),
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    _loadingOrder
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : TextButton(
                            child: Text(
                              "Place Order",
                              style: _orderButtonDisabled
                                  ? TextStyle(color: Colors.grey)
                                  : TextStyle(color: Colors.black),
                            ),
                            onPressed: (_orderButtonDisabled||_loadingOrder)
                                ? null
                                : () async {
                                    setState(() {
                                      _loadingOrder = true;
                                    });
                                    await Provider.of<Orders>(context,
                                            listen: false)
                                        .addOrder(cart.items.values.toList(),
                                            cart.totalAmount);
                                    cart.clear();
                                    setState(() {
                                      _loadingOrder = false;
                                    });
                                  },
                          ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            cart.items.isEmpty
                ? Center(
                    child: Text("You have no items in your cart!"),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: cart.items.length,
                      itemBuilder: ((context, i) {
                        return CartItemDisplay(
                            cartItemKey: cart.items.keys.toList()[i],
                            cartItem: cart.items.values.toList()[i]);
                      }),
                    ),
                  ),
          ],
        ));
  }
}
