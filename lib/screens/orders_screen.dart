import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/side_drawer.dart';

import '../providers/orders.dart';
import '../widgets/order_item_display.dart';

class OrdersScreen extends StatefulWidget {
  static const String routeName = "/orders";

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var _isLoadingOrders = false;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) async {
      setState(() {
        _isLoadingOrders = true;
      });
      await Provider.of<Orders>(context, listen: false).fetchOrders();
      setState(() {
        _isLoadingOrders = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Your Orders"),
      ),
      body: _isLoadingOrders
          ? Center(
              child: CircularProgressIndicator(),
            )
          : orderData.orders.length == 0
              ? Center(
                  child: Text("Sorry, no orders have been sent!"),
                )
              : ListView.builder(
                  itemCount: orderData.orders.length,
                  itemBuilder: ((context, i) =>
                      OrderItemDisplay(orderItem: orderData.orders[i])),
                ),
      drawer: SideDrawer(),
    );
  }
}
