import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transactions.dart';

class TransactionList extends StatelessWidget {
  final List<Transactions> transactions;
  final Function _delete;

  TransactionList(this.transactions,this._delete);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 300,
        child: transactions.isEmpty
            ? Column(
                children: <Widget>[
                  Text(
                    'no transaction yet',
                    style: Theme.of(context).textTheme.title,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      height: 200,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.cover,
                      )),
                ],
              )
            : ListView.builder(
                itemBuilder: (ctx, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8,horizontal: 5),
                     elevation: 5,
                     child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          child: Padding(
                            padding: EdgeInsets.all(6),
                            child: FittedBox(
                              child: Text('\$${transactions[index].ammount}'),
                            ),
                          ),
                        ),
                        title: Text('${transactions[index].title}',style: Theme.of(context).textTheme.title
                        ),
                        subtitle: Text(DateFormat.yMMMd().format(transactions[index].date)),
                       trailing: IconButton(icon: Icon(Icons.delete), onPressed:()=> _delete(transactions[index].id),color: Theme.of(context).errorColor,),
                      )
                  );
                },
                itemCount: transactions.length,
              ));
  }
}
