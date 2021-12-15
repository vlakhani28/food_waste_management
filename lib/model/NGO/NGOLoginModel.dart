import 'package:cloud_firestore/cloud_firestore.dart';

class NGOModel {
  static const ID = "id";
  static const NAME = "name";
  static const EMAIL = "email";
  static const ADDRESS = "address";
  static const UIN = "uin";

  String _name;
  String _email;
  String _address;
  String _uin;
  String _id;

  String get name => _name;
  String get email => _email;
  String get address => _address;
  String get uin => _uin;
  String get id => _id;

  NGOModel.fromSnapshot(DocumentSnapshot snapshot) {
    _name = snapshot[NAME];
    _email = snapshot[EMAIL];
    _address = snapshot[ADDRESS];
    _uin = snapshot[UIN];
    _id = snapshot[ID];
  }
}