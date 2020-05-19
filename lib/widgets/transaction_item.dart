import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';


class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.deleteOperation,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteOperation;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 2),
      child: ListTile(
        leading: CircleAvatar(
            radius: 30,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FittedBox(
                  child: Column(
                children: <Widget>[
                  Text("Rs"),
                  Text(
                      "${transaction.amount.toStringAsFixed(2)}",
                      style: Theme.of(context).textTheme.title),
                ],
              )),
            )),
        title: Text(
          "Title : ${transaction.title}",
          style: Theme.of(context).textTheme.title,
        ),
        subtitle: Text(new DateFormat("d MMMM y")
            .format(transaction.date)),
        trailing: MediaQuery.of(context).size.width > 360
            ? FlatButton.icon(
                icon: Icon(Icons.delete),
                label: Text("delete"),
                onPressed: () {
                  deleteOperation(transaction.id);
                },
                color: Theme.of(context).errorColor)
            : IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  deleteOperation(transaction.id);
                },
                color: Theme.of(context).errorColor,
              ),
      ),
    );
  }
}
