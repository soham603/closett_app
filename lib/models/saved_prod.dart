import 'package:flutter/material.dart';

class SavedProductsModel extends ChangeNotifier {
  List<Map<String, dynamic>> _savedProducts = [];

  List<Map<String, dynamic>> get savedProducts => _savedProducts;

  void addToSavedProducts(Map<String, dynamic> product) {
    _savedProducts.add(product);
    notifyListeners();
  }

  void removeFromSavedProducts(Map<String, dynamic> product) {
    _savedProducts.remove(product);
    notifyListeners();
  }
}