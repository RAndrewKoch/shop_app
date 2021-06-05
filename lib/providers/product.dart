import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/models/http_exception.dart';

class Product with ChangeNotifier {
  final String? id;
  final String? title;
  final String? description;
  final double? price;
  final String? imageUrl;
  bool isFavorite;

  Product(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.imageUrl,
      this.isFavorite = false});

  Future<void> toggleFavoriteStatus() async {
    final url = Uri.parse(
        "https://flutter-shop-app-110f1-default-rtdb.firebaseio.com/products/${this.id}.json");
    isFavorite = !isFavorite;
    notifyListeners();
    final response = await http.patch(
      url,
      body: json.encode({
        "isFavorite": this.isFavorite,
      }),
    );
    if (response.statusCode >= 400) {
      print("400+ code thrown");
      this.isFavorite = !this.isFavorite;
      notifyListeners();
      throw HttpException("Favorite did not update");
    }
  }

  @override
  String toString() {
    return "Instance of Product{id: \"${this.id}\", title: \"${this.title}\", description: \"${this.description}\", price: ${this.price}, imageUrl: ${this.imageUrl}, isFavorite: ${this.isFavorite}}";
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Product &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          description == other.description &&
          price == other.price &&
          imageUrl == other.imageUrl &&
          isFavorite == other.isFavorite;

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      description.hashCode ^
      price.hashCode ^
      imageUrl.hashCode ^
      isFavorite.hashCode;
}
