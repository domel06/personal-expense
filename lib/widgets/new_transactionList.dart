import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final TextEditingController titlecontroller = TextEditingController();

  final TextEditingController amountcontroller = TextEditingController();

  void submittData() {
    final  enteredTitle = titlecontroller.text;
    final  enteredAmount = double.parse(amountcontroller.text);

    if (enteredTitle.isEmpty || enteredAmount<0){
      return;
    }
    widget.addTx(enteredTitle, enteredAmount);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(

      child: Card(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                  decoration: InputDecoration(labelText: 'title'),
                  // onChanged:(val) {
                  //   titleInput = val;
                  // }
                  controller: titlecontroller,
                  onSubmitted: (_) => submittData()),
              TextField(
                decoration: InputDecoration(labelText: 'amount'),
                // onChanged:(val) => amountInput = val,
                controller: amountcontroller,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => submittData(),
              ),
              FlatButton(
                onPressed: submittData,
                child: Text('Add Transaction'),
                textColor: Colors.purple,
              )
            ],
          ),
        ),
        elevation: 50,
      ),
    );
  }
}
