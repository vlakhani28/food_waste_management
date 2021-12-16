import 'package:flutter/cupertino.dart';

class NGOHomeField {
  static const createdTime = 'createdTime';
}

class NGODataHome {
  DateTime createdTime;
  String id;
  String quantity;
  String veg;
  String pickUpDay;
  String mealType;
  bool isDone;

  NGODataHome({
    @required this.createdTime,
    @required this.quantity,
    @required this.veg,
    @required this.mealType,
    @required this.pickUpDay,
    this.id,
    this.isDone = false,
  });
}