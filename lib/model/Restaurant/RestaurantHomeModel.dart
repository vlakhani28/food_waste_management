import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class RestaurantDataHome {
  static const createdTime = "createdTime";
  static const dishName = "dishName";
  static const ID = "id";
  static const QUANTITY = "quantity";
  static const VEG = "veg";
  static const cookedBefore = "cookedBefore";
  static const withContainer = "withContainer";
  static const pickUpDay = "pickUpDay";
  static const mealType = "mealType";
  static const isDone = "isDone";

  Timestamp _createdTime;
  String _dishName;
  String _id;
  int _quantity;
  String _veg;
  int _cookedBefore;
  String _withContainer;
  String _pickUpDay;
  String _mealType;
  int _isDone;

  Timestamp get createdtime => _createdTime;
  String get dishname => _dishName;
  String get id => _id;
  int get quantity => _quantity;
  String get veg => _veg;
  int get cookedbefore => _cookedBefore;
  String get withcontainer => _withContainer;
  String get pickupday => _pickUpDay;
  String get mealtype => _mealType;
  int get isdone => _isDone;

  RestaurantDataHome.fromSnapshot(DocumentSnapshot snapshot) {
    _createdTime = snapshot[createdTime];
    _dishName = snapshot[dishName];
    _id = snapshot[ID];
    _quantity = snapshot[QUANTITY];
    _veg = snapshot[VEG];
    _cookedBefore = snapshot[cookedBefore];
    _withContainer = snapshot[withContainer];
    _pickUpDay = snapshot[pickUpDay];
    _mealType = snapshot[mealType];
    _isDone = snapshot[isDone];
  }

}
class RestaurantDataHistory {
  static const createdTime = "createdTime";
  static const ID = "id";
  static const QUANTITY = "quantity";
  static const VEG = "veg";
  static const pickUpDay = "pickUpDay";
  static const mealType = "mealType";
  static const isDone = "isDone";
  static const NGO = "ngo";
  static const DATE = "date";

  String _createdTime;
  String _id;
  String _quantity;
  String _veg;
  String _pickUpDay;
  String _mealType;
  String _isDone;
  String _ngo;
  String _date;

  String get createdtime => _createdTime;
  String get id => _id;
  String get quantity => _quantity;
  String get veg => _veg;
  String get pickupday => _pickUpDay;
  String get mealtype => _mealType;
  String get isdone => _isDone;
  String get ngo => _ngo;
  String get date => _date;

  RestaurantDataHistory.fromSnapshot(DocumentSnapshot snapshot) {
    _createdTime = snapshot[createdTime];
    _id = snapshot[ID];
    _quantity = snapshot[QUANTITY];
    _veg = snapshot[VEG];
    _pickUpDay = snapshot[pickUpDay];
    _mealType = snapshot[mealType];
    _isDone = snapshot[isDone];
    _ngo = snapshot[NGO];
    _date = snapshot[DATE];
  }
}