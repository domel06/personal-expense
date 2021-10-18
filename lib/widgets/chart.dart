import 'package:flutter/material.dart';
import 'package:personal_expense_app/models/transactions.dart';
import 'package:intl/intl.dart';
import 'package:personal_expense_app/widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transactions> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.0;
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].ammount;
        }
      }
      print(DateFormat.E().format(weekDay));
      print(totalSum);
      return {
        'Days': DateFormat.E().format(weekDay).substring(0, 1),
        'ammount': totalSum
      };
    });
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + item['ammount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);
    return Card(
        elevation: 6,
        margin: EdgeInsets.all(20),
        child: Container(
          padding: EdgeInsets.all(10),
           child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: groupedTransactionValues.map((data) {
                return Flexible(
                    fit: FlexFit.tight,
                    child: Chartbar(
                        data['Days'],
                        data['ammount'],
                        totalSpending == 0.0
                            ? 0.0
                            : (data['ammount'] as double) / totalSpending));
              }).toList(),
            )
        ));
  }
}
