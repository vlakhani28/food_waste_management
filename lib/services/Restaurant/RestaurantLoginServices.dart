import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_waste_management/model/Restaurant/RestaurantHomeModel.dart';
import 'package:food_waste_management/model/Restaurant/RestaurantLoginModel.dart';

class UserServices {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String collection = "restaurant";
  String postsCollection = "posts";
  String historyCollection = "history";
  createUser(Map<String, dynamic> data) async {
    try {
      await _firestore.collection(collection).doc(data["id"]).set(data);
      print("User Created");
    } catch (e) {
      print('ERROR: ${e.toString()}');
    }
  }

  Future<RestaurantModel> getUserById(String id) =>
      _firestore.collection(collection).doc(id).get().then(
            (doc) {
          print("==========id is $id=============");
          print(doc);
          return RestaurantModel.fromSnapshot(doc);
        },
      );

  void addPost(Map<String, dynamic> data, String id) async {
    try {
      await _firestore
          .collection(collection)
          .doc(id)
          .collection(postsCollection)
          .doc(data['id'])
          .set(data);
      print('Post Added');
    } catch (e) {
      print('ERROR: ${e.toString()}');
    }
  }
  void addHistory(Map<String, dynamic> data, String id) async {
    try {
      await _firestore
          .collection(collection)
          .doc(id)
          .collection(historyCollection)
          .doc(data['id'])
          .set(data);
      print('History Added');
    } catch (e) {
      print('ERROR: ${e.toString()}');
    }
  }

  void removePost(String contactId, String id) async {
    try {
      await _firestore
          .collection(collection)
          .doc(id)
          .collection(postsCollection)
          .doc(contactId)
          .delete();
      print('Post Removed');
    } catch (e) {
      print('ERROR: ${e.toString()}');
    }
  }
  void removeHistory(String contactId, String id) async {
    try {
      await _firestore
          .collection(collection)
          .doc(id)
          .collection(historyCollection)
          .doc(contactId)
          .delete();
      print('History Removed');
    } catch (e) {
      print('ERROR: ${e.toString()}');
    }
  }

  Future<List<RestaurantDataHome>> getPosts({String userId}) async {
    _firestore
        .collection(collection)
        .doc(userId)
        .collection(postsCollection)
        .get()
        .then(
          (result) {
        List<RestaurantDataHome> posts = [];
        for (DocumentSnapshot post in result.docs) {
          posts.add(RestaurantDataHome.fromSnapshot(post));
        }
        return posts;
      },
    );
  }
  Future<List<RestaurantDataHistory>> getHistory({String userId}) async {
    _firestore
        .collection(collection)
        .doc(userId)
        .collection(historyCollection)
        .get()
        .then(
          (result) {
        List<RestaurantDataHistory> history = [];
        for (DocumentSnapshot contact in result.docs) {
          history.add(RestaurantDataHistory.fromSnapshot(contact));
        }
        return history;
      },
    );
  }
}