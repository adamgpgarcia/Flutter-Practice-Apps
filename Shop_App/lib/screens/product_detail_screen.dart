import 'package:flutter/material.dart';
import '../providers/products.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  // final String title;

  // ProductDetailScreen(this.title);

  static const routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    final productID = ModalRoute.of(context).settings.arguments as String;
    //final loadedProduct = Provider.of<Products>(context).findById(productID);     default
    final loadedProduct = Provider.of<Products>(context, listen: false).findById(productID);  //listen = false wont rebuild the widget every time there is a change, default will rebuild with every change
   
    return Scaffold(
      appBar: AppBar(title: Text(loadedProduct.title)),
      body: Column( children: <Widget> [
        Text(loadedProduct.title),
        Text(loadedProduct.price.toString()),
        Text(loadedProduct.id),
      ]
      ),
      
    );
  }
}