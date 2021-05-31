import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/side_drawer.dart';


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
      drawer: SideDrawer(),
    );
  }
}
