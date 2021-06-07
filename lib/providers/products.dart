import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shop_app/models/http_exception.dart';

import './product.dart';
import 'auth.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];
  final String? token;
  final String? userId;

  Products(this.token, this.userId, this._items);

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((prod) => prod.isFavorite == true).toList();
  }

  Product findById(String productId) {
    return _items.firstWhere((product) => product.id == productId);
  }

  Future<void> fetchAndSetProducts([bool filterByUser = false]) async {

    var url = Uri.parse(filterByUser?
    "https://flutter-shop-app-110f1-default-rtdb.firebaseio.com/products.json?auth=$token&orderBy=\"creatorId\"&equalTo=\"$userId\"":
        "https://flutter-shop-app-110f1-default-rtdb.firebaseio.com/products.json?auth=$token");
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>?;
      final List<Product> loadedProducts = [];
      if (extractedData==null){
        return;
      }
      url = Uri.parse(
          "https://flutter-shop-app-110f1-default-rtdb.firebaseio.com/userFavorites/$userId.json?auth=$token");
      final favoriteResponse = await http.get(url);
      final favoriteData = json.decode(favoriteResponse.body);

      extractedData.forEach((productId, value) {
        loadedProducts.add(
          Product(
              id: productId,
              title: value["title"],
              description: value["description"],
              price: value["price"],
              imageUrl: value["imageUrl"],
              isFavorite: favoriteData == null? false : favoriteData[productId] ?? false),
        );
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      print(error);
      throw (error);
    }
  }

  Future<void> addProduct(Product product) async {
    final url = Uri.parse(
        "https://flutter-shop-app-110f1-default-rtdb.firebaseio.com/products.json?auth=$token");
    try {
      final response = await http.post(
        url,
        body: json.encode({
          "title": product.title,
          "description": product.description,
          "imageUrl": product.imageUrl,
          "price": product.price,
          "creatorId" : userId,
        }),
      );
      final newProduct = Product(
        title: product.title,
        price: product.price,
        imageUrl: product.imageUrl,
        description: product.description,
        id: json.decode(response.body)["name"],
      );
      _items.insert(0, newProduct);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updateProduct(Product product) async {
    final replacingIndex = _items.indexWhere((prod) => prod.id == product.id);
    if (replacingIndex >= 0) {
      final url = Uri.parse(
          "https://flutter-shop-app-110f1-default-rtdb.firebaseio.com/products/${product.id}.json?auth=$token");
      await http.patch(
        url,
        body: json.encode({
          "title": product.title,
          "description": product.description,
          "price": product.price,
          "imageUrl": product.imageUrl,
        }),
      );
      _items[replacingIndex] = product;
      notifyListeners();
    }
  }

  Future<void> removeProduct(Product product, BuildContext context) async{
    final url = Uri.parse(
        "https://flutter-shop-app-110f1-default-rtdb.firebaseio.com/products/${product.id}.json?auth=$token");
    Product existingProduct = product;
    final existingProductIndex = _items.indexWhere((prod) => product.id == prod.id);
    _items.remove(product);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode>=400) {
      print("400 code thrown");
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();

      throw HttpException("Could not delete product");

    }
  }
}
