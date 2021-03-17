import './Widgets/new_transaction.dart';
import 'package:flutter/material.dart';
import './Model/transactions.dart';
import './Widgets/transactions_list.dart';
import './Widgets/chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.green,
          fontFamily: 'QuickSand',
          textTheme: ThemeData.light().textTheme.copyWith(
              //to apply theme directly to transaction_list
              title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
              button: TextStyle(color: Colors.white)),
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
          )),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _showChart = false;
  final List<Transactions> _transactions = [
    Transactions(
      id: 'tx1',
      title: 'shoes',
      amount: 9.99,
      date: DateTime.now(),
    ),
    Transactions(
      id: 'tx2',
      title: 'shoes',
      amount: 9.99,
      date: DateTime.now(),
    ),
    Transactions(
      id: 'tx3',
      title: 'shoes',
      amount: 9.99,
      date: DateTime.now(),
    ),
    Transactions(
      id: 'tx4',
      title: 'shoes',
      amount: 9.99,
      date: DateTime.now(),
    ),
    Transactions(
      id: 'tx5',
      title: 'shoes',
      amount: 9.99,
      date: DateTime.now(),
    ),
    Transactions(
      id: 'tx6',
      title: 'shoes',
      amount: 9.99,
      date: DateTime.now(),
    ),
  ];

  void _addNewTransaction(
      String txtitle, double txamount, DateTime selectDate) {
    final newTx = Transactions(
        id: DateTime.now().toString(),
        title: txtitle,
        amount: txamount,
        date: selectDate);
    setState(() {
      _transactions.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tx) => tx.id == id);
    });
  }

  List<Transactions> get _recentTransactions {
    return _transactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(_addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandScape = mediaQuery.orientation == Orientation.landscape;

    final appbar = AppBar(
      backgroundColor: Colors.purple,
      title: Text('Flutter App'),
      actions: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
        )
      ],
    );
    final txList = Container(
        height: (mediaQuery.size.height -
                appbar.preferredSize.height -
                mediaQuery.padding.top) *
            0.7,
        child: TransactionList(_transactions, _deleteTransaction));
    return Scaffold(
      appBar: appbar,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isLandScape)
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Show Chart: ',
                        style: TextStyle(fontSize: 18),
                      ),
                      Switch(
                          value: _showChart,
                          onChanged: (val) {
                            setState(() {
                              _showChart = val;
                            });
                          })
                    ],
                  ),
                  _showChart
                      ? Container(
                          height: (mediaQuery.size.height -
                                  appbar.preferredSize.height -
                                  mediaQuery.padding.top) *
                              0.7,
                          child: Chart(_recentTransactions))
                      : txList,
                ],
              ),
            if (!isLandScape)
              Container(
                  height: (mediaQuery.size.height -
                          appbar.preferredSize.height -
                          mediaQuery.padding.top) *
                      0.3,
                  child: Chart(_recentTransactions)),
            if (!isLandScape) txList
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewTransaction(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
