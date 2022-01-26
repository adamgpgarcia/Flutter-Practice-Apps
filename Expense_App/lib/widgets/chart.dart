import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import '../models/transaction.dart';
import './chart_bars.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  //This function groups transaction values based on date and orders depending on date
  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      double totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year)
          totalSum += recentTransactions[i].amount;
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0,
            1), //format converts the date time value, substring takes first value from Sun = S
        'amount': totalSum,
      };
    }).reversed.toList(); //orders the chart days in order of oldest on right
  }

  double get totalSpending {
    //streamlined return with a return
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  //This function calls chart bart to display the chart bars in a card
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                data['day'],
                data['amount'],
                totalSpending == 0.0
                    ? 0.0
                    : (data['amount'] as double) / totalSpending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
