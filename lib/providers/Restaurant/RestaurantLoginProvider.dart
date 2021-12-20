import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_waste_management/model/Restaurant/RestaurantHomeModel.dart';
import 'package:food_waste_management/model/Restaurant/RestaurantLoginModel.dart';
import 'package:food_waste_management/services/Restaurant/RestaurantLoginServices.dart';
import 'package:food_waste_management/widgets/CustomSnackBar.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class RestaurantProvider with ChangeNotifier {
  FirebaseAuth _auth;
  User _user;
  Status _status = Status.Uninitialized;
  UserServices _userServices = UserServices();
  RestaurantModel _userModel;
  List<RestaurantDataHome> posts = [];
  List<RestaurantDataHistory> history = [];
  // getter
  RestaurantModel get userModel => _userModel;
  Status get status => _status;
  User get user => _user;

  RestaurantProvider.initialize() : _auth = FirebaseAuth.instance {
    _auth.authStateChanges().listen(_onStateChanged);
  }

  Future<bool> signIn(
      String email, String password, BuildContext context) async {
    try {
      _status = Status.Authenticating;
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
      _status = Status.Unauthenticated;
      notifyListeners();
      CustomSnackbar.show(context, e.toString());
      return false;
    }
  }

  Future<bool> signUp(String name, String email, String password,
      String address, String mobileNumber, BuildContext context) async {
    try {
      _status = Status.Authenticating;
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
          'mobileNumber': mobileNumber
        });
        notifyListeners();
      });
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      CustomSnackbar.show(context, e.toString());
      return false;
    }
  }

  Future<void> _onStateChanged(User user) async {
    if (user == null) {
      _status = Status.Unauthenticated;
    } else {
      _user = user;
      // _userModel = await _userServices.getUserById(user.uid);
      _status = Status.Authenticated;
    }
    notifyListeners();
  }

  Future signOut() async {
    _auth.signOut();
    _status = Status.Unauthenticated;
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