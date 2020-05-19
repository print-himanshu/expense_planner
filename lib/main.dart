import './widgets/new_transaction.dart';
import './models/transaction.dart';
import './widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import './widgets/chart.dart';

void main() => (runApp(HomePage()));

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter App",
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          fontFamily: 'Quicksand',
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  button: TextStyle(
                    color: Colors.white,
                  ),
                ),
          ),
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'Quicksand',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              )),
      home: Main(),
    );
  }
}

class Main extends StatefulWidget {
  
    bool _switchFlag = true;
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  final List<Transaction> _userTransactions = [
    Transaction(
      id: "1 No.",
      title: "New Shoes",
      amount: 5500,
      date: DateTime.now().subtract(Duration(days: 2)),
    ),
    Transaction(
      id: "2 No.",
      title: "New Laptop",
      amount: 1000,
      date: DateTime.now(),
    ),
  ];

  List<Transaction> get recentTransaction {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(String title, double amount, DateTime selectedDate) {
    final newTx = Transaction(
      title: title,
      amount: amount,
      id: DateTime.now().toString(),
      date: selectedDate,
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            child: NewTransaction(_addNewTransaction),
            onTap: () {},
          );
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((item) => item.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text("Expense Manager"),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
        ),
      ],
    );

    final totalAvailableHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.portrait;


    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: isLandscape == true
            ?  Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
              height: totalAvailableHeight * 0.3,
              child: Chart(recentTransaction)),
          Container(
              child: TransactionList(_userTransactions, _deleteTransaction),
              height: totalAvailableHeight * 0.7),
        ])
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Show Chart"),
                      Switch(
                        value: widget._switchFlag,
                        onChanged: (bool val) {
                          setState(() {
                            widget._switchFlag = val;
                            print("Switch Flag : ${widget._switchFlag}");
                          });
                        },
                      ),
                    ],
                  ),
                  widget._switchFlag == true
                      ? Container(
                          height: totalAvailableHeight * 0.7,
                          child: Chart(recentTransaction))
                      : Container(
                          child: TransactionList(
                              _userTransactions, _deleteTransaction),
                          height: totalAvailableHeight * 0.7),
                ],
              ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
