import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';
import 'chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;
  double totalAmount = 0.0;

  Chart(this.recentTransaction);

  List<Map<String, Object>> get groupedTransaction {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      double totalSum = 0.0;

      for (var i = 0; i < recentTransaction.length; i++) {
        if (recentTransaction[i].date.day == weekDay.day &&
            recentTransaction[i].date.month == weekDay.month &&
            recentTransaction[i].date.year == weekDay.year)
          totalSum += recentTransaction[i].amount;
      }
      totalAmount += totalSum;
      return {
        'Day': DateFormat.E().format(weekDay),
        'Amount': totalSum,
      };
    }).reversed.toList();
  }

  double get totalAmountByMethod {
    return groupedTransaction.fold(0.0, (sum, item) {
      return sum + item['Amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: groupedTransaction.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                label: data['Day'],
                spendingAmount: data['Amount'],
                spendingPctOfAmount: totalAmount == 0.0
                    ? 0.0
                    : (data['Amount'] as double) / totalAmount,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
