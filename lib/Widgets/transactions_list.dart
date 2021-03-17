import 'package:expense_recorder/Model/transactions.dart';
import 'package:expense_recorder/Widgets/transaction_item.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Transactions> transactions;
  final Function deleteTransaction;
  TransactionList(this.transactions, this.deleteTransaction);
  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Container(
                height: 200,
                child: Image.asset(
                  'assets/images/waiting.png',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          )
        : ListView(
            children: transactions.map((tx) {
            return TransactionItem(
                key: ValueKey(tx.id),
                transaction: tx,
                deleteTransaction: deleteTransaction);
          }).toList());
  }
}
