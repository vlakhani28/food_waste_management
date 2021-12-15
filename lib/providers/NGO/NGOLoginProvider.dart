import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_waste_management/model/ContactModel.dart';
import 'package:food_waste_management/model/NGO/NGOLoginModel.dart';
import 'package:food_waste_management/services/NGO/NGOLoginServices.dart';
import 'package:food_waste_management/widgets/CustomSnackBar.dart';

enum StatusNGO { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class NGOProvider with ChangeNotifier {
  FirebaseAuth _auth;
  User _user;
  StatusNGO _status = StatusNGO.Uninitialized;
  NGOServices _userServices = NGOServices();
  NGOModel _userModel;
  List<ContactModel> contacts = [];

  // getter
  NGOModel get userModel => _userModel;
  StatusNGO get status => _status;
  User get user => _user;

  NGOProvider.initialize() : _auth = FirebaseAuth.instance {
    _auth.authStateChanges().listen(_onStateChanged);
  }

  Future<bool> signIn(
      String email, String password, BuildContext context) async {
    try {
      _status = StatusNGO.Authenticating;
      notifyListeners();
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        _userModel = await _userServices.getUserById(value.user.uid);
        CustomSnackbar.show(context, 'Logged In Successfully');
        notifyListeners();
      });
      return true;
    } catch (e) {
      _status = StatusNGO.Unauthenticated;
      notifyListeners();
      CustomSnackbar.show(context, e.toString());
      return false;
    }
  }

  Future<bool> signUp(String name, String email, String password,
      String address, String uin, BuildContext context) async {
    try {
      _status = StatusNGO.Authenticating;
      notifyListeners();
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((user) async {
        print("CREATE USER");
        _userServices.createUser({
          'id': user.user.uid,
          'name': name,
          'email': email,
          'address': address,
          'uin': uin
        });
        notifyListeners();
      });
      return true;
    } catch (e) {
      _status = StatusNGO.Unauthenticated;
      notifyListeners();
      CustomSnackbar.show(context, e.toString());
      return false;
    }
  }

  Future<void> _onStateChanged(User user) async {
    if (user == null) {
      _status = StatusNGO.Unauthenticated;
    } else {
      _user = user;
      //_userModel = await _userServices.getUserById(user.uid);
      _status = StatusNGO.Authenticated;
    }
    notifyListeners();
  }

  Future signOut() async {
    _auth.signOut();
    _status = StatusNGO.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  // getContacts() async {
  //   contacts = await _userServices.getEmergencyContacs(userId: userModel.id);
  //   notifyListeners();
  // }
  //
  // Future<void> reloadContacts() async {
  //   contacts = await _userServices.getEmergencyContacs(userId: userModel.id);
  //   notifyListeners();
  // }
  //
  // Future<bool> addSingleContact(
  //     String name, String relation, String mobileNumber, String id) async {
  //   try {
  //     _userServices.addContact({
  //       'name': name,
  //       'relation': relation,
  //       'mobileNumber': mobileNumber,
  //       'id': id
  //     }, userModel.id);
  //     print('Add Contact');
  //     notifyListeners();
  //     return true;
  //   } catch (e) {
  //     print("THE ERROR ${e.toString()}");
  //     return false;
  //   }
  // }
  //
  // Future<bool> removeSingleContact(String contactId) async {
  //   try {
  //     _userServices.removeContact(contactId, userModel.id);
  //     return true;
  //   } catch (e) {
  //     print("THE ERROR ${e.toString()}");
  //     return false;
  //   }
  // }
}