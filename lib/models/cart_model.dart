import 'package:flutter/material.dart';
import 'package:demo3/models/menu_list.dart';

class CartModel extends ChangeNotifier {
  // List of items on sale
  final List<MenuList> _shopItems = MenuList.getMenu();

  // List of cart items
  List<MenuList> _cartItems = [];

  List<MenuList> get cartItems => _cartItems;
  List<MenuList> get shopItems => _shopItems;

  // Add item to cart
  void addItemToCart(int index) {
    _cartItems.add(_shopItems[index]);
    notifyListeners();
  }

  // Remove item from cart
  void removeItemFromCart(int index) {
    _cartItems.removeAt(index);
    notifyListeners();
  }

  // Calculate total price
  String calculateTotal() {
    double totalPrice = 0;
    for (int i = 0; i < _cartItems.length; i++) {
      totalPrice += double.parse(_cartItems[i].price);
    }
    return totalPrice.toStringAsFixed(0);
  }
}
