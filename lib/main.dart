//redirected to ProductOverviewScreen

import 'package:flutter/material.dart';
import "package:provider/provider.dart";
import 'package:shop_app/providers/orders.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/screens/edit_product_screen.dart';
import 'package:shop_app/screens/orders_screen.dart';
import 'package:shop_app/screens/product_detail_screen.dart';
import 'package:shop_app/screens/user_products_screen.dart';
import 'screens/product_overview_screen.dart';
import 'providers/cart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Products(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider.value(
          value: Orders(),
        )
      ],
      // return ChangeNotifierProvider(
      //   create: (ctx) {
      //     return Products();
      //   },
      //value: Products(),
      child: MaterialApp(
        title: "MyShop",
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ).copyWith(
          colorScheme: ThemeData().colorScheme.copyWith(
                secondary: Colors.deepOrange,
              ),
        ),
        home: ProductOverviewScreen(),
        routes: {
          ProductDetailScreen.routename: (context) => ProductDetailScreen(),
          CartScreen.routeName: (context) => CartScreen(),
          OrdersScreen.routeName: (context) => OrdersScreen(),
          UserProductScreen.routeName: (context) => UserProductScreen(),
          EditProduct.routeName: (context) => EditProduct(),
        },
      ),
    );
  }
}
