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
  static const orderPlaced = "orderPlaced";
  static const ID = "id";
  static const DISHNAME = "dishName";
  static const QUANTITY = "quantity";
  static const VEG = "veg";
  static const pickUpDay = "pickUpDay";
  static const WITHCONTAINER = "withContainer";
  static const mealType = "mealType";
  static const COOKEDBEFORE = "cookedBefore";
  static const NGONAME = "ngoName";
  static const NGOUIN = "ngoUIN";

  Timestamp _orderPlaced;
  String _dishName;
  String _id;
  int _quantity;
  String _veg;
  String _pickUpDay;
  String _withContainer;
  String _mealType;
  int _cookedBefore;
  String _ngoName;
  String _ngoUIN;

  Timestamp get createdtime => _orderPlaced;
  String get id => _id;
  String get dishName => _dishName;
  int get quantity => _quantity;
  String get veg => _veg;
  String get pickupday => _pickUpDay;
  String get withContainer => _withContainer;
  String get mealtype => _mealType;
  int get cookedBefore => _cookedBefore;
  String get ngoName => _ngoName;
  String get ngoUIN => _ngoUIN;

  RestaurantDataHistory.fromSnapshot(DocumentSnapshot snapshot) {
    _orderPlaced = snapshot[orderPlaced];
    _id = snapshot[ID];
    _dishName = snapshot[DISHNAME];
    _quantity = snapshot[QUANTITY];
    _veg = snapshot[VEG];
    _pickUpDay = snapshot[pickUpDay];
    _withContainer = snapshot[WITHCONTAINER];
    _mealType = snapshot[mealType];
    _cookedBefore = snapshot[COOKEDBEFORE];
    _ngoName = snapshot[NGONAME];
    _ngoUIN = snapshot[NGOUIN];
  }
}