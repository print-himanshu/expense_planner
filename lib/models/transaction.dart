import 'package:flutter/material.dart';

class Transaction {
  @required
  final String title;
  @required
  final String id;
  @required
  final double amount;
  @required
  final DateTime date;

  Transaction({
    this.title,
    this.id,
    this.amount,
    this.date,
  });
}
