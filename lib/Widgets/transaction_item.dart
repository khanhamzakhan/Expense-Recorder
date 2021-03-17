import 'dart:math';
import 'package:flutter/material.dart';
import '../Model/transactions.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.deleteTransaction,
  }) : super(key: key);

  final Transactions transaction;
  final Function deleteTransaction;

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  Color _bgColors;
  @override
  void initState() {
    const availableColors = [
      Colors.amber,
      Colors.black,
      Colors.red,
      Colors.blueAccent,
      Colors.green,
      Colors.lightGreen,
      Colors.grey
    ];
    _bgColors = availableColors[Random().nextInt(7)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(10),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _bgColors,
          radius: 30,
          child: Padding(
            padding: EdgeInsets.all(6),
            child: FittedBox(
                child:
                    Text('\$${widget.transaction.amount.toStringAsFixed(2)}')),
          ),
        ),
        title: Text(widget.transaction.title),
        subtitle: Text(
          DateFormat.yMMMd().format(widget.transaction.date),
        ),
        trailing: MediaQuery.of(context).size.width > 460
            ? FlatButton.icon(
                onPressed: () =>
                    widget.deleteTransaction(widget.transaction.id),
                icon: Icon(
                  Icons.delete,
                ),
                textColor: Theme.of(context).errorColor,
                label: Text('Delete'))
            : IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).errorColor,
                ),
                onPressed: () =>
                    widget.deleteTransaction(widget.transaction.id),
              ),
      ),
    );
  }
}
