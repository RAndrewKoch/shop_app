import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../providers/orders.dart';

class OrderItemDisplay extends StatelessWidget {
  final OrderItem orderItem;

  OrderItemDisplay({required this.orderItem});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('\$${orderItem.amount.toStringAsFixed(2)}'),
            subtitle: Text(
              DateFormat("dd MM yyyy hh:mm").format(orderItem.dateTime),
            ),
            trailing: IconButton(
              icon: Icon(Icons.expand_more),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}