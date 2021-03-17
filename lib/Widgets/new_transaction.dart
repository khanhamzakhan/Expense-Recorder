import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;
  NewTransaction(this.addTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleContainer = TextEditingController();

  final _amountContainer = TextEditingController();

  DateTime _selectDate;

  void _submitData() {
    if (_amountContainer.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleContainer.text;
    final enteredAmount = double.parse(_amountContainer.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectDate == null) {
      return;
    }
    widget.addTransaction(enteredTitle, enteredAmount, _selectDate);
    Navigator.of(context).pop();
  }

  void _datePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.only(
              left: 10,
              top: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: _titleContainer,
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Amount',
                ),
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
                controller: _amountContainer,
              ),
              Container(
                child: Row(
                  children: [
                    Text(_selectDate == null
                        ? 'No Date Chosen yet!'
                        : 'Date Picked: ${DateFormat.yMd().format(_selectDate)}'),
                    Expanded(
                      child: FlatButton(
                        onPressed: _datePicker,
                        child: Text(
                          'Choose Date.',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              RaisedButton(
                onPressed: _submitData,
                child: Text(
                  'Add Transaction',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.button.color,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
