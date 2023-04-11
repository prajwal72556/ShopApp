import 'package:flutter/material.dart';

class CartItems {
  final String id;
  final String title;
  int quantity;
  final double price;
  //final String productid;
  CartItems({
    //required this.productid,
    required this.id,
    required this.title,
    required this.quantity,
    required this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItems> _items = {};

  Map<String, CartItems> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmt {
    double total = 0.0;
    _items.forEach((key, cartitems) {
      total += cartitems.price * cartitems.quantity;
    });
    return total;
  }

  void addItem(String productId, double price, String title) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (existingCartItem) => CartItems(
              id: existingCartItem.id,
              title: existingCartItem.title,
              quantity: existingCartItem.quantity + 1,
              price: existingCartItem.price
              // productid: existingCartItem.productid),
              ));
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItems(
          id: DateTime.now().toString(),
          title: title,
          quantity: 1,
          price: price,
          //productid: productId,
        ),
      );
    }
    notifyListeners();
  }

  void deleteitem(String Productid) {
    _items.remove(Productid);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId]!.quantity > 1) {
      _items[productId]!.quantity -= 1;
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }
}
