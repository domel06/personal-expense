import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final TextEditingController _titlecontroller = TextEditingController();

  final TextEditingController _amountcontroller = TextEditingController();
  DateTime _dateSelected;

  void _submittData() {
    final enteredTitle = _titlecontroller.text;
    final enteredAmount = double.parse(_amountcontroller.text);

    if (enteredTitle.isEmpty || enteredAmount < 0 || _dateSelected == null) {
      return;
    }
    widget.addTx(enteredTitle, enteredAmount,_dateSelected);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2019),
        lastDate: DateTime.now()).then((val) {
          if (val==null){
            return;
          }
          setState(() {
            _dateSelected = val;
          });

    });
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
                  controller: _titlecontroller,
                  onSubmitted: (_) => _submittData()),
              TextField(
                decoration: InputDecoration(labelText: 'amount'),
                // onChanged:(val) => amountInput = val,
                controller: _amountcontroller,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submittData(),
              ),
              Container(
                  height: 70,
                  child: Row(
                    children: <Widget>[
                      Expanded(child: Text(_dateSelected == null
                          ? 'no date choosen'
                          : 'Date picked:${DateFormat.yMd().format(_dateSelected)}')),
                      FlatButton(
                        textColor: Colors.purple,
                        onPressed: _presentDatePicker,
                        child: Text("choose date"),
                      ),
                    ],
                  )),
              RaisedButton(
                onPressed: _submittData,
                textColor: Theme.of(context).textTheme.button.color,
                child: Text('Add Transaction'),
                color: Theme.of(context).primaryColor,
              )
            ],
          ),
        ),
        elevation: 50,
      ),
    );
  }
}
