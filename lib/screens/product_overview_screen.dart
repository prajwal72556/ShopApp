//contains the AppBar  and the things that need to display in the appbar
//actions=[] contain the PopupMenuButton which is the three dot
//itemBuilder of the PopUpMenuButton  contains the PopupMenuItem objects

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import '../widgets/products_grid.dart';
import '../providers/products_provider.dart';
import '../widgets/badge1.dart';
import './cart_screen.dart';

enum FilterOptions { Favourites, All }

class ProductOverviewScreen extends StatefulWidget {
  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  bool _showFavourite = false;
  @override
  Widget build(BuildContext context) {
    //final productsData = Provider.of<Products>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("My Shop"),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          PopupMenuButton(
            onSelected: (FilterOptions selected) {
              setState(() {
                if (selected == FilterOptions.Favourites) {
                  _showFavourite = true;
                  //productsData.showFavourites();
                } else {
                  //productsData.showall();
                  _showFavourite = false;
                }
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (ctx) => [
              const PopupMenuItem(
                value: FilterOptions.Favourites,
                child: Text("Only Favourites"),
              ),
              const PopupMenuItem(
                value: FilterOptions.All,
                child: Text("Show all"),
              )
            ],
          ),
          Consumer<Cart>(
            builder: (_, cartdata, ch) => Badge1(
              child: ch!,
              value: cartdata.itemCount.toString(),
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () =>
                  Navigator.of(context).pushNamed(CartScreen.routeName),
            ),
          )
        ],
      ),
      drawer: AppDrawer(),
      body: ProductsGrid(_showFavourite),
    );
  }
}
