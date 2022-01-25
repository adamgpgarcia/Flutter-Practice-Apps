import 'package:flutter/material.dart';

import './widgets/new_transactions.dart';
import './widgets/transactions_list.dart';
import './models/transaction.dart';
import './widgets/chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense App',
      theme: ThemeData(
          primarySwatch: Colors.purple,
          //accentColor: Colors.amber,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
                /*title: TextStyle(
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),*/
                button: TextStyle(color: Colors.white),
              ),
          appBarTheme: AppBarTheme(
              /* textTheme: ThemeData.light().textTheme.copyWith(
            title: TextStyle(             //says this is deprecated 
              fontFamily: 'OpenSans',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          )*/
              )),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: 't1',
    //   title: 'New Shoes',
    //   amount: 59.99,
    //   date: DateTime.now(),
    // ),

    // Transaction(
    //   id: 't2',
    //   title: 'Weekly Groceries',
    //   amount: 100.99,
    //   date: DateTime.now(),
    // ),
  ];
  //This getter returns a list of transactions that happened in the last 7 days. Using the where command to return a sublist that matches the conditions
  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      //where returns an iterible but we need a list returned
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList(); //this converts the iterible to a list
  }

  void _addNewTransactions(
      String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }
  // short hand return example
  // _userTransactions.removeWhere((tx) => tx.id == id);

  // requires context of flutter application called ctx to avoid confusion with context
  void _startAddNewTransaction(BuildContext ctx) {
    //bCtx is not the same context as ctx but its also a requirement which we can sub for "builder(_)"  , means i know that I get it but i dont care
    showModalBottomSheet(
      context: ctx,
      builder: (bCtx) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addNewTransactions),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    //context = flutter meta data
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Personal Expenses'),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(
                context), //must make this an ananoymoys function to pass context as a parameter, reason cant have function() sitting by itself otherwise it would run on runtime
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Chart(_recentTransactions),
            TransactionList(_userTransactions, _deleteTransaction),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
