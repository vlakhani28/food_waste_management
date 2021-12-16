import 'package:flutter/cupertino.dart';

class RestaurantHomeField {
  static const createdTime = 'createdTime';
}

class RestaurantDataHome {
  DateTime createdTime;
  String dishName;
  String id;
  String quantity;
  String veg;
  int cookedBefore;
  String withContainer;
  String pickUpDay;
  String mealType;
  bool isDone;

  RestaurantDataHome({
    @required this.createdTime,
    @required this.dishName,
    @required this.quantity,
    @required this.veg,
    @required this.cookedBefore,
    @required this.withContainer,
    @required this.mealType,
    @required this.pickUpDay,
    this.id,
    this.isDone = false,
  });
}