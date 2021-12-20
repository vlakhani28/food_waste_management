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

  String _createdTime;
  String _id;
  String _quantity;
  String _veg;
  String _pickUpDay;
  String _mealType;
  String _isDone;

  String get createdtime => _createdTime;
  String get id => _id;
  String get quantity => _quantity;
  String get veg => _veg;
  String get pickupday => _pickUpDay;
  String get mealtype => _mealType;
  String get isdone => _isDone;

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
  static const createdTime = "createdTime";
  static const ID = "id";
  static const QUANTITY = "quantity";
  static const VEG = "veg";
  static const pickUpDay = "pickUpDay";
  static const mealType = "mealType";
  static const isDone = "isDone";
  static const RESTAURANT = "restaurant";
  static const DATE = "date";

  String _createdTime;
  String _id;
  String _quantity;
  String _veg;
  String _pickUpDay;
  String _mealType;
  String _isDone;
  String _restaurant;
  String _date;

  String get createdtime => _createdTime;
  String get id => _id;
  String get quantity => _quantity;
  String get veg => _veg;
  String get pickupday => _pickUpDay;
  String get mealtype => _mealType;
  String get isdone => _isDone;
  String get restaurant => _restaurant;
  String get date => _date;

  NGODataHistory.fromSnapshot(DocumentSnapshot snapshot) {
    _createdTime = snapshot[createdTime];
    _id = snapshot[ID];
    _quantity = snapshot[QUANTITY];
    _veg = snapshot[VEG];
    _pickUpDay = snapshot[pickUpDay];
    _mealType = snapshot[mealType];
    _isDone = snapshot[isDone];
    _restaurant = snapshot[RESTAURANT];
    _date = snapshot[DATE];
  }
}