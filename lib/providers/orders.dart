import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import './cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    required this.id,
    required this.amount,
    required this.products,
    required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  final String? authToken;
  final String? userId;

  Orders(this.authToken, this.userId, this._orders);

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final url = Uri.parse(
        "https://flutter-shop-app-110f1-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authToken");
    final dateTime = DateTime.now();
    final response = await http.post(
      url,
      body: json.encode({
        "total": total,
        "dateTime": dateTime.toIso8601String(),
        "cartProducts": cartProducts
            .map((item) => {
                  "id": item.id,
                  "title": item.title,
                  "quantity": item.quantity,
                  "price": item.price,
                })
            .toList(),
      }),
    );
    _orders.insert(
      0,
      OrderItem(
        id: json.decode(response.body)["name"],
        amount: total,
        products: cartProducts,
        dateTime: dateTime,
      ),
    );
    notifyListeners();
  }

  Future<void> fetchOrders() async {
    final url = Uri.parse(
        "https://flutter-shop-app-110f1-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authToken");

    final response = await http.get(url);
    Map<String,dynamic>? retrievedOrders = json.decode(response.body) as Map<String, dynamic>?;
    if (retrievedOrders==null){
      return;
    }
    List<OrderItem> orders = [];
    retrievedOrders.forEach((key, value) {
      orders.add(OrderItem(
        id: key,
        amount: value["total"],
        dateTime: DateTime.parse(value["dateTime"]),
        products: (value["cartProducts"] as List<dynamic>)
            .map(
              (item) => CartItem(
                id: item["id"],
                price: item["price"],
                quantity: item["quantity"],
                title: item["title"],
              ),
            )
            .toList(),
      ));
    });
    _orders = orders.reversed.toList();

    notifyListeners();
  }
}
