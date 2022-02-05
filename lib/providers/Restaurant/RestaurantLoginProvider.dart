import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_waste_management/model/NGO/NGOHomeModel.dart';
import 'package:food_waste_management/model/Restaurant/RestaurantHomeModel.dart';
import 'package:food_waste_management/model/Restaurant/RestaurantLoginModel.dart';
import 'package:food_waste_management/services/Restaurant/RestaurantLoginServices.dart';
import 'package:food_waste_management/widgets/CustomSnackBar.dart';
import 'package:intl/intl.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class RestaurantProvider with ChangeNotifier {
  FirebaseAuth _auth;
  User _user;
  Status _status = Status.Uninitialized;
  UserServices _userServices = UserServices();
  RestaurantModel _userModel;
  List<RestaurantDataHome> posts = [];
  List<NGODataHome> NGOPosts = [];
  String name;
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
      _userModel = await _userServices.getUserById(user.uid);
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

  Future getPosts() async {
    posts = await _userServices.getPosts(userId: userModel.id);
    notifyListeners();
  }

  Future getNGO() async {
    NGOPosts = await _userServices.getNGO();
    notifyListeners();
  }
  Future getHistory() async {
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

  // void removePostsHours()  {
  //   FirebaseFirestore.instance
  //       .collection('restaurant')
  //       .get()
  //       .then((QuerySnapshot querySnapshot) {
  //     querySnapshot.docs.forEach((doc) {
  //       FirebaseFirestore.instance
  //           .doc(doc.id)
  //           .collection("posts")
  //           .get().then((value) async {
  //
  //         for(var posts in value.docs)
  //         {
  //            DateTime dt1 = DateTime.parse(DateFormat('yyyy-MM-dd – kk:mm').format(posts['createdTime']));
  //            DateTime dt2 = DateTime.parse(DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now()));
  //            Duration diff = dt1.difference(dt2);
  //            if(diff.inHours - posts["cookedBefore"] > 12)
  //              {
  //                await removePost(doc.id, doc["id"]);
  //              }
  //         }
  //       });
  //     });
  //   });
  // }

  Future<bool> removePost(String postId, String userId) async {
    try {
      _userServices.removePost(postId, userId);
      return true;
    } catch (e) {
      print("THE ERROR ${e.toString()}");
      return false;
    }
  }

  Future<bool> removeOnGoing(String postId, String userId) async {
    try {
      _userServices.removeOnGoing(postId, userId);
      return true;
    } catch (e) {
      print("THE ERROR ${e.toString()}");
      return false;
    }
  }

  Future<bool> addPost(DateTime timestamp, String dishname, String id, int quantity, String veg, int cookedBefore, String withContainer,
      String pickUpDay, String mealType, int isDone) async {
    try {
      _userServices.addPost({
        'createdTime': timestamp,
        'dishName':dishname,
        'id': id,
        'quantity': quantity,
        'veg': veg,
        'cookedBefore': cookedBefore,
        'withContainer': withContainer,
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

  Future<bool> addOnGoing(DateTime timestamp, String dishname, String id, int quantity, String veg, int cookedBefore, String withContainer,
      String pickUpDay, String mealType, String uin,String ngo, String ngoId,String userId) async {
    try {
      _userServices.addOnGoing({
        'orderPlaced': timestamp,
        'dishName':dishname,
        'id': id,
        'quantity': quantity,
        'veg': veg,
        'cookedBefore': cookedBefore,
        'withContainer': withContainer,
        'pickUpDay': pickUpDay,
        'mealType': mealType,
        'ngoUIN': ngo,
        'ngoName': uin,
        'ngoId': ngoId,
      }, userId);
      print('Add OnGoing');
      notifyListeners();
      return true;
    } catch (e) {
      print("THE ERROR ${e.toString()}");
      return false;
    }
  }

  Future<bool> addHistory(Timestamp timestamp, String dishname, String id, int quantity, String veg, int cookedBefore, String withContainer,
      String pickUpDay, String mealType, String uin,String ngo,String ngoId, String userId) async {
    try {
      _userServices.addHistory({
        'orderPlaced': timestamp,
        'dishName':dishname,
        'id': id,
        'quantity': quantity,
        'veg': veg,
        'cookedBefore': cookedBefore,
        'withContainer': withContainer,
        'pickUpDay': pickUpDay,
        'mealType': mealType,
        'ngoUIN': uin,
        'ngoName': ngo,
        'ngoId': ngoId,
      }, userId);
      print('Add History');
      notifyListeners();
      return true;
    } catch (e) {
      print("THE ERROR ${e.toString()}");
      return false;
    }
  }
}