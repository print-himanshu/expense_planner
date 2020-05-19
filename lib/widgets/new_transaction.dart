import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function _pressedMethod;
  _NewTransactionState createState() => _NewTransactionState();
  NewTransaction(this._pressedMethod);
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleBox = TextEditingController();
  final _amountBox = TextEditingController();
  DateTime _selectedDate;

  void _submitButton() {
    final String titleValue = _titleBox.text;
    final num amountValue = double.parse(_amountBox.text);

    if (titleValue.isEmpty || amountValue <= 0 || _selectedDate == null) return;

    widget._pressedMethod(titleValue, amountValue, _selectedDate);

    Navigator.of(context).pop();
  }

  void _pickingDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((datePicked) {
      if (datePicked == null) return null;

      setState(() {
        _selectedDate = datePicked;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  labelText: "Title",
                ),
                controller: _titleBox,
                onSubmitted: (_) => _submitButton(),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "Amount",
                ),
                controller: _amountBox,
                onSubmitted: (_) => _submitButton(),
              ),
              Container(
                height: 60,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(_selectedDate == null
                          ? "No Date Chooosen!"
                          : "Picked Date: ${DateFormat.yMd().format(_selectedDate)}"),
                    ),
                    FlatButton(
                      child: Text(
                        "Choose Date",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      onPressed: () {
                        _pickingDate();
                      },
                    )
                  ],
                ),
              ),
              RaisedButton(
                child: Text(
                  "Add Transactions",
                ),
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.button.color,
                onPressed: () => _submitButton(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
