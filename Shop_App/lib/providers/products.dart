import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];

  //var _showFavoritesOnly = false;

  List<Product> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  List<Product> get items {
    //example to have filtered return
    // if ( _showFavoritesOnly){
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [..._items]; // ... is the spread operator
  }

  //Dont want to change list in Products file, app wide state which will trasfer over to other screens which we mostlikely dont want
  // void showFavoritesOnly(){
  //   _showFavoritesOnly = true;
  //   notifyListeners();
  // }

  // void showAll(){
  //   _showFavoritesOnly = false;
  //   notifyListeners();
  // }

  //find item by id
  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  //This function uses GET to get JSON on the products in the database
  Future<void> getSetProducts() async {
    var headers = {'Content-Type': 'application/json'};
    const url = 'http://10.0.2.2:8001/product/';
    //trys to request a GET and catches errors if they occur
    try {
      final response = await http.get(url, headers: headers);
      final extractedData = json.decode(response.body) as List<dynamic>;
      final List<Product> loadedProducts = [];

      //for loop cycles through data and checks if isFavorite is true or false and sets bool local value for Product constructor
      for (int i = 0; i < extractedData.length; i++) {
        bool tempFav;
        if (extractedData[i]['isFavorite'] == "true") {
          tempFav = true;
        } else {
          tempFav = false;
        }
        var temp = Product(
          id: extractedData[i]['id'].toString(),
          title: extractedData[i]['title'],
          description: extractedData[i]['description'],
          price: double.parse(extractedData[i]['price']),
          imageUrl: extractedData[i]['imageUrl'],
          isFavorite: tempFav,
        );
        loadedProducts.add(temp);
      }
      //database items stored to local list
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  //adds product to database via HTTP Post
  Future<void> addProduct(Product product) {
    //creates correct text for editior
    var headers = {'Content-Type': 'application/json'};
    //url of server where HTTP will connect
    const url = 'http://10.0.2.2:8001/product/';
    //sends the post after encoding product into json, data dictionary style format
    return http
        .post(
      url,
      headers: headers,
      body: json.encode({
        'productID': 12312,
        'title': product.title,
        'price': product.price,
        'description': product.description,
        'imageUrl': product.imageUrl,
        'isFavorite': product.isFavorite,
        //if there is an error code from the server then 'then' records the response
      }),
    )
        .then((response) {
      print(json.decode(response.body));
      final newProduct = Product(
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        id: (json.decode(response.body)['id']).toString(),
      );
      //if POST was successful then item is added to local list
      _items.add(newProduct);
      //_items.insert(0, newProduct); //insert at the begining of the list
      notifyListeners();
    }).catchError((onError) {
      throw onError;
    });
    //print(json.decode(response.body));
  }

  void updateProduct(String id, Product newProduct) {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    //if product has an index then item is updated
    if (prodIndex >= 0) {
      _items[prodIndex] = newProduct;
      notifyListeners();
    }
    //catches if product is not in _items
    else {
      print('...');
    }
  }

  //removeWhere checks list for products that have the same id, listeners notified
  void deleteProduct(String id) {
    _items.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }
}
