import 'package:flutter/foundation.dart';

class Transaction {
  final String id;              //run time const that will not change
  final String title;
  final double amount;
  final DateTime date;

  Transaction({
    @required this.id,          //required is apart of dart and is in material.dart and foundation.dart
    @required this.title, 
    @required this.amount, 
    @required this.date
  });
}
