import 'package:flutter/foundation.dart';

//Cart Item class
class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price,
  });
}

//Change Notifiers update all widgets in their widget tries when there is a change in data value
class Cart with ChangeNotifier {
  //creating map list
  Map<String, CartItem> _items = {};

  //populating items list
  Map<String, CartItem> get items {
    return {..._items};
  }

  //returns amount of items in list
  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;

    //forEach is a for loop type funtion, adds up cost x quantity for each item
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void removeSingleItem(String productId) {
    //if items does not contain productID Return
    if (!_items.containsKey(productId)) {
      return;
    }
    //checks if there is more then 1 of that item in the item list and reduces quanity by one
    if (_items[productId].quantity > 1) {
      _items.update(
        productId,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          title: existingCartItem.title,
          price: existingCartItem.price,
          quantity: existingCartItem.quantity - 1,
        ),
      );
    }
    //if there is only one of that product in the _items that ID is removed
    else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  //removes entire selection of one item
  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  //adds one item to the _items via update function
  void addItem(String productId, double price, String title) {
    //if there is already is one item in _items quantity is increased by 1
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (existingCartItem) => CartItem(
            id: DateTime.now().toString(),
            title: title,
            price: price,
            quantity: existingCartItem.quantity + 1),
      );
      //if item is absent from the _items one item is added to the list
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
            id: DateTime.now().toString(),
            title: title,
            price: price,
            quantity: 1),
      );
    }
    //this updates the widget tree that there has been a change
    notifyListeners();
  }
}
