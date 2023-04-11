import 'package:flutter/material.dart';
import './cart.dart';

class OrderItem {
  final String id;
  final double price;
  final List<CartItems> products;
  final DateTime dateTime;

  OrderItem(
      {required this.id,
      required this.price,
      required this.products,
      required this.dateTime});
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItems> cartProducts, double total) {
    _orders.insert(
      0,
      OrderItem(
        id: DateTime.now().toString(),
        price: total,
        products: cartProducts,
        dateTime: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}
