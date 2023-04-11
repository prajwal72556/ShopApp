import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';
import '../widgets/app_drawer.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/ordersScreen';

  var expanded = false;

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("Your orders"),
        ),
        drawer: AppDrawer(),
        body: orderData.orders.length == 0
            ? Container(
                alignment: Alignment.center, child: Text("No orders Yet !!"))
            : ListView.builder(
                itemBuilder: (ctx, index) {
                  return OrderItem(
                    orderData.orders[index],
                  );
                },
                itemCount: orderData.orders.length,
              ));
  }
}
