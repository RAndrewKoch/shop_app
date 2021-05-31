import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../providers/orders.dart';
import '../screens/products_overview_screen.dart';
import '../widgets/order_item_display.dart';

class OrdersScreen extends StatelessWidget {
  static const String routeName = "/orders";

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Your Orders"),
      ),
      body: ListView.builder(
        itemCount: orderData.orders.length,
        itemBuilder: ((context, i) =>
            OrderItemDisplay(orderItem: orderData.orders[i])),
      ),
      drawer: Drawer(
        child: Container(
          color: Theme.of(context).primaryColor,
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Text('Actions'),
              Container(
                height: 500,
                child: ListView(
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context)
                          .pushReplacementNamed(OrdersScreen.routeName),
                      child: Text(
                        "Orders",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context)
                          .pushReplacementNamed(
                          ProductsOverviewScreen.routeName),
                      child: Text(
                        "Products Overview",
                        style: TextStyle(color: Colors.black),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
