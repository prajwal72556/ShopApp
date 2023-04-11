import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "../providers/products_provider.dart";

class ProductDetailScreen extends StatelessWidget {
  //final String title;

  static const routename = "/product-details";

  //ProductDetailScreen(this.title);

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)?.settings.arguments;
    final loadedProduct = Provider.of<Products>(
      context,
      listen: false, //this will not rebuild this widget
    ).findById(
      productId as String,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              child: Image.network(
                loadedProduct.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              " \$ ${loadedProduct.price}",
              style: TextStyle(color: Colors.grey, fontSize: 20),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
              ),
              width: double.infinity,
              child: Text(
                loadedProduct.description,
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            )
          ],
        ),
      ),
    );
  }
}
