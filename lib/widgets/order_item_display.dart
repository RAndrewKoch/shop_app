import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../providers/orders.dart';

class OrderItemDisplay extends StatefulWidget {
  final OrderItem orderItem;

  OrderItemDisplay({required this.orderItem});

  @override
  _OrderItemDisplayState createState() => _OrderItemDisplayState();
}

class _OrderItemDisplayState extends State<OrderItemDisplay> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('\$${widget.orderItem.amount.toStringAsFixed(2)}'),
            subtitle: Text(
              DateFormat("dd MM yyyy hh:mm").format(widget.orderItem.dateTime),
            ),
            trailing: IconButton(
              icon:
                  expanded ? Icon(Icons.expand_less) : Icon(Icons.expand_more),
              onPressed: () {
                setState(() {
                  expanded = !expanded;
                });
              },
            ),
          ),
          AnimatedContainer(
            duration: Duration(
              milliseconds: 250,
            ),
            decoration: BoxDecoration(
              border: expanded ? Border.all() : Border(),
            ),
            height: expanded
                ? min(widget.orderItem.products.length * 30.0 + 50.0, 190.0)
                : 0,
            child: Scrollbar(
              child: ListView.builder(
                itemCount: widget.orderItem.products.length,
                itemBuilder: (context, i) => ListTile(
                  title: Text(widget.orderItem.products[i].title),
                  leading: CircleAvatar(
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                            '\$${widget.orderItem.products[i].price.toStringAsFixed(2)}'),
                      ),
                    ),
                  ),
                  trailing: Text('${widget.orderItem.products[i].quantity}x'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
