import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPtgofTotalAmount;

  ChartBar(
      {@required this.label,
      @required this.spendingAmount,
      @required this.spendingPtgofTotalAmount});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, Constraints) {
      return Column(
        children: [
          Container(
              height: Constraints.maxHeight * 0.15,
              child: FittedBox(
                  child: Text('\$${spendingAmount.toStringAsFixed(0)}'))),
          SizedBox(
            height: 0.05,
          ),
          Container(
            height: Constraints.maxHeight * 0.6,
            width: 10,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.0),
                      color: Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(10)),
                ),
                FractionallySizedBox(
                  heightFactor: spendingPtgofTotalAmount,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 0.05,
          ),
          Container(
              height: Constraints.maxHeight * 0.15,
              child: FittedBox(child: Text(label))),
        ],
      );
    });
  }
}
