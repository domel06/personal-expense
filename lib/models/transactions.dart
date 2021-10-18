import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class Transactions {
  final String id;
  final String title;
  final double ammount;
  final DateTime date;

  Transactions(

  {

  @required this.id

  ,

  @required this.title

  ,

  @required this.ammount

  ,

  @required this.date
});
}