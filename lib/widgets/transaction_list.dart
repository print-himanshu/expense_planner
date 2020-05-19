import 'package:expense_planner/models/transaction.dart';
import 'package:flutter/material.dart';
import './transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteOperation;
  TransactionList(
    this.transactions,
    this.deleteOperation,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 300,
        child: transactions.isEmpty
            ? Column(
                children: <Widget>[
                  Text("No Entry is available "),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 200,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              )
            : ListView.builder(
                itemBuilder: (cntx, index) {
                  return TransactionItem(
                      transaction: transactions[index],
                      deleteOperation: deleteOperation);
                },
                itemCount: transactions.length,
              ));
  }
}
