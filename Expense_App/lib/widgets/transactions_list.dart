import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      child: transactions.isEmpty
          ? Column(
              children: <Widget>[
                Text(
                  'No transactions added yet!',
                  //style: Theme.of(context).textTheme.title,
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  //box fit works to fit image to current dimentions but column returns infinite so a container with set dementions should wrap the image
                  height: 200,
                  child: Image.asset(
                    'assets/image/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 10,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text('\$${transactions[index].amount}'),
                        ),
                      ),
                    ),
                    title: Text(
                      transactions[index].title,
                      //style: Theme.of(context).textTheme.title,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(transactions[index].date),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                      onPressed: () =>
                          deleteTransaction(transactions[index].id),
                    ),
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}


// return Card(
//                   child: Row(
//                     children: <Widget>[
//                       Container(
//                         width: 100,
//                         padding: EdgeInsets.all(10),
//                         margin: EdgeInsets.symmetric(
//                           vertical: 10,
//                           horizontal: 15,
//                         ),
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                             color: Theme.of(context)
//                                 .primaryColor, //like naviagtion pop example, gives theme data from main
//                             width: 2,
//                           ),
//                         ),
//                         child: Text(
//                           '\$${transactions[index].amount.toStringAsFixed(2)}', //fixes percision on user amount input
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 20,
//                               color: Theme.of(context).primaryColor),
//                         ),
//                       ),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           Text(
//                             transactions[index].title,
//                             style: Theme.of(context).textTheme.title,
//                           ),
//                           Text(
//                             DateFormat.yMMMd().format(transactions[index]
//                                 .date), // DateFormat('yyyy/MM/dd')   or DateFormat.yMMMMd()
//                             style: TextStyle(color: Colors.grey),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 );


