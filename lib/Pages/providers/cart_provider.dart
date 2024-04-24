import 'dart:convert';

import 'package:ecommarce/core/constains/shared_preference_keys.dart';
import 'package:ecommarce/model/product_model.dart';
import 'package:ecommarce/model/product_quantity.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider with ChangeNotifier {
  List<ProductQuantityModel> _items = [];
  double totalPrice = 0;
  int totalItemCount = 0;
  late SharedPreferences _sp;

  List<ProductQuantityModel> get items {
    return _items;
  }

  CartProvider() {
    _loadCart();
  }

  void addProduct(ProductModel product) {
    for (var item in _items) {
      if (item.product.id == product.id) {
        item.quantity += 1;
        notifyListeners();
        _CalculateTotalPriceAndItem();
        _saveCart();
        return;
      }
    }
    _items.add(ProductQuantityModel(product: product, quantity: 1));
    notifyListeners();
    _CalculateTotalPriceAndItem();
    _saveCart();
  }

  void removeProduct(ProductModel product) {
    for (var item in _items) {
      if (item.product.id == product.id) {
        item.quantity -= 1;
        if (item.quantity == 0) {
          _items.remove(item);
        }
        notifyListeners();
        _CalculateTotalPriceAndItem();
        _saveCart();
      }
    }
    notifyListeners();
    _CalculateTotalPriceAndItem();
    _saveCart();
  }

  void _CalculateTotalPriceAndItem() {
    totalPrice = 0;
    totalItemCount = 0;
    for (var item in _items) {
      totalPrice = (item.product.price ?? 0) * item.quantity;
      totalItemCount = item.quantity;
    }
    notifyListeners();
  }

  int CountProduct(ProductModel product) {
    for (var item in _items) {
      if (item.product.id == product.id) {
        return item.quantity;
      }
    }
    return 0;
  }

  bool payNow(String cardNumber) {
    Map response = jsonDecode(FakePayment.pay(cardNumber));
    if (response["success"] == true) {
      _items = [];
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> _saveCart() async {
    print("save cart");
    List<String> cartData = [];
    for (var item in items) {
      cartData.add(jsonEncode(item.toJson()));
    }
    _sp = await SharedPreferences.getInstance();
    _sp.setString(SharedPreferenceKeys.CART, cartData.toString());
  }

  Future<void> _loadCart() async {
    _sp = await SharedPreferences.getInstance();
    List cartData = jsonDecode(_sp.getString(SharedPreferenceKeys.CART) ?? "");
    for (var item in cartData) {
      _items.add(ProductQuantityModel.fromJson(item));
    }
    notifyListeners();
  }
}

class FakePayment {
  static String pay(String cardNumber) {
    if (cardNumber == "1111") {
      return '''
  {
    "success": true
  }
''';
    }
    return '''
{
  "success": false
}
''';
  }
}
