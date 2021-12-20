import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_waste_management/model/NGO/NGOHomeModel.dart';
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
  List<NGODataHome> posts = [];
  List<NGODataHistory> history = [];

  // getter
  NGOModel get userModel => _userModel;

  StatusNGO get status => _status;

  User get user => _user;

  NGOProvider.initialize() : _auth = FirebaseAuth.instance {
    _auth.authStateChanges().listen(_onStateChanged);
  }

  Future<bool> signIn(String email, String password,
      BuildContext context) async {
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

  getPosts() async {
    posts = await _userServices.getPosts(userId: userModel.id);
    notifyListeners();
  }

  getHistory() async {
    history = await _userServices.getHistory(userId: userModel.id);
    notifyListeners();
  }

  Future<void> reloadPosts() async {
    posts = await _userServices.getPosts(userId: userModel.id);
    notifyListeners();
  }

  Future<void> reloadHistory() async {
    history = await _userServices.getHistory(userId: userModel.id);
    notifyListeners();
  }

  Future<bool> removePost(String postId) async {
    try {
      _userServices.removePost(postId, userModel.id);
      return true;
    } catch (e) {
      print("THE ERROR ${e.toString()}");
      return false;
    }
  }

  Future<bool> addPost(DateTime timestamp, String id, int quantity, String veg,
      String pickUpDay, String mealType, int isDone) async {
    try {
      _userServices.addPost({
        'createdTime': timestamp,
        'id': id,
        'quantity': quantity,
        'veg': veg,
        'pickUpDay': pickUpDay,
        'mealType': mealType,
        'isDone': isDone,
      }, userModel.id);
      print('Add Post');
      notifyListeners();
      return true;
    } catch (e) {
      print("THE ERROR ${e.toString()}");
      return false;
    }
  }

  Future<bool> addHistory(DateTime timestamp, String id, int quantity, String veg,
      String pickUpDay, String mealType, int isDone, String restaurant, DateTime date) async {
    try {
      _userServices.addPost({
        'createdTime': timestamp,
        'id': id,
        'quantity': quantity,
        'veg': veg,
        'pickUpDay': pickUpDay,
        'mealType': mealType,
        'isDone': isDone,
        'restaurant': restaurant,
        'date': date
      }, userModel.id);
      print('Add Post');
      notifyListeners();
      return true;
    } catch (e) {
      print("THE ERROR ${e.toString()}");
      return false;
    }
  }
}