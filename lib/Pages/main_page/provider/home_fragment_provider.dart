import 'dart:convert';

import 'package:ecommarce/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeFragmentProvider with ChangeNotifier {
  List<ProductModel> products = [];
  List CateGories = ["All"];
  bool isProductLoading = true;
  bool isCategoryLoading = true;
  int selectedTabIndex = 0;
  HomeFragmentProvider() {
    loadAllProducts();
    loadAllCategories();
  }
  Future<void> loadAllProducts() async {
    http.Response res =
        await http.get(Uri.parse("https://fakestoreapi.com/products"));
    if (res.statusCode == 200) {
      List allProducts = jsonDecode(res.body);
      allProducts.forEach((productMap) {
        products.add(ProductModel.fromJson(productMap));
      });
    } else {
      print("Erorr");
    }
    print(products);
    isProductLoading = false;
    notifyListeners();
  }

  Future<void> loadproductsCategory(String CategoryName) async {
    http.Response res = await http.get(
        Uri.parse("https://fakestoreapi.com/products/category/$CategoryName"));
    if (res.statusCode == 200) {
      products = [];
      List allProducts = jsonDecode(res.body);
      allProducts.forEach((productMap) {
        products.add(ProductModel.fromJson(productMap));
      });
    } else {
      print("Erorr");
    }
    print(products);
    isProductLoading = false;
    notifyListeners();
  }

  void loadAllCategories() async {
    http.Response res = await http
        .get(Uri.parse("https://fakestoreapi.com/products/categories"));
    if (res.statusCode == 200) {
      CateGories.addAll(jsonDecode(res.body));
    } else {
      print("Erorr");
    }
    print(CateGories);
    isCategoryLoading = false;
    notifyListeners();
  }

  void ChangeProductCategoryTab(int index) async {
    selectedTabIndex = index;
    notifyListeners();
    isProductLoading = true;
    if (index == 0) {
      await loadAllProducts();
    } else {
      await loadproductsCategory(CateGories[index]);
    }
  }
}
