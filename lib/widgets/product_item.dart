import 'package:flutter/material.dart';
import '../screens/product_detail_screen.dart';
import 'package:provider/provider.dart';
import '../providers/product.dart';
import '../providers/cart.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;

  // ProductItem({
  //   required this.id,
  //   required this.title,
  //   required this.imageUrl,
  // });
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context,
        listen: false); //we are listining to the provider
    final cart = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routename,
              arguments: product.id,
            );
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        header: Text("header"),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Product>(
            builder: (context, product, child) => IconButton(
              icon: Icon(
                product.isFavourite
                    ? Icons.favorite
                    : Icons.favorite_border_outlined,
                color: Colors.deepOrange,
              ),
              onPressed: () {
                product.toggleIsFavourite();
              },
            ),
          ),
          trailing: IconButton(
            icon: const Icon(
              Icons.shopping_cart,
              color: Colors.deepOrange,
            ),
            onPressed: () {
              cart.addItem(product.id, product.price!, product.title);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  //backgroundColor: Colors.black45,
                  content: Text(
                    "Item added ",
                    textAlign: TextAlign.center,
                  ),
                  duration: Duration(seconds: 5),
                  action: SnackBarAction(
                    label: "Undo",
                    onPressed: () {
                      cart.deleteitem(product.id);
                    },
                  ),
                ),
              );
            },
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
