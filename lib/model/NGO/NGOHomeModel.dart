import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NGODataHome {
  static const createdTime = "createdTime";
  static const ID = "id";
  static const QUANTITY = "quantity";
  static const VEG = "veg";
  static const pickUpDay = "pickUpDay";
  static const mealType = "mealType";
  static const isDone = "isDone";

  Timestamp _createdTime;
  String _id;
  int _quantity;
  String _veg;
  String _pickUpDay;
  String _mealType;
  int _isDone;

  Timestamp get createdtime => _createdTime;
  String get id => _id;
  int get quantity => _quantity;
  String get veg => _veg;
  String get pickupday => _pickUpDay;
  String get mealtype => _mealType;
  int get isdone => _isDone;

  NGODataHome.fromSnapshot(DocumentSnapshot snapshot) {
    _createdTime = snapshot[createdTime];
    _id = snapshot[ID];
    _quantity = snapshot[QUANTITY];
    _veg = snapshot[VEG];
    _pickUpDay = snapshot[pickUpDay];
    _mealType = snapshot[mealType];
    _isDone = snapshot[isDone];
  }
}

class NGODataHistory {
  static const orderPlaced = "orderPlaced";
  static const ID = "id";
  static const DISHNAME = "dishName";
  static const QUANTITY = "quantity";
  static const VEG = "veg";
  static const pickUpDay = "pickUpDay";
  static const WITHCONTAINER = "withContainer";
  static const mealType = "mealType";
  static const COOKEDBEFORE = "cookedBefore";
  static const RESTNAME = "restName";
  static const RESTNumber = "restNumber";

  DateTime _orderPlaced;
  String _dishName;
  String _id;
  int _quantity;
  String _veg;
  String _pickUpDay;
  String _withContainer;
  String _mealType;
  int _cookedBefore;
  String _restName;
  String _restNumber;

  DateTime get createdtime => _orderPlaced;
  String get id => _id;
  String get dishName => _dishName;
  int get quantity => _quantity;
  String get veg => _veg;
  String get pickupday => _pickUpDay;
  String get withContainer => _withContainer;
  String get mealtype => _mealType;
  int get cookedBefore => _cookedBefore;
  String get restName => _restName;
  String get restNumber => _restNumber;

  NGODataHistory.fromSnapshot(DocumentSnapshot snapshot) {
    _orderPlaced = snapshot[orderPlaced];
    _id = snapshot[ID];
    _dishName = snapshot[DISHNAME];
    _quantity = snapshot[QUANTITY];
    _veg = snapshot[VEG];
    _pickUpDay = snapshot[pickUpDay];
    _withContainer = snapshot[WITHCONTAINER];
    _mealType = snapshot[mealType];
    _cookedBefore = snapshot[COOKEDBEFORE];
    _restName = snapshot[RESTNAME];
    _restNumber = snapshot[RESTNumber];
  }
}