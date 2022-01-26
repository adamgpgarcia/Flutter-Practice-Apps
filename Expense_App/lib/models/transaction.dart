import 'package:flutter/foundation.dart';

//Class definition
class Transaction {
  final String id; //final is a run time const that will not change
  final String title;
  final double amount;
  final DateTime date;

  //Class constructor
  Transaction(
      {
      //required is apart of dart and is in material.dart and foundation.dart
      @required this.id,
      @required this.title,
      @required this.amount,
      @required this.date});
}
