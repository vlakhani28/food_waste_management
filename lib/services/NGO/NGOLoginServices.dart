import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_waste_management/model/NGO/NGOHomeModel.dart';
import 'package:food_waste_management/model/NGO/NGOLoginModel.dart';

class NGOServices {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String collection = "NGO";
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

  Future<NGOModel> getUserById(String id) =>
      _firestore.collection(collection).doc(id).get().then(
            (doc) {
              print(doc.data());
          print("==========id is $id=============");
          return NGOModel.fromSnapshot(doc);
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

  Future<List<NGODataHome>> getPosts({String userId}) async {
    _firestore
        .collection(collection)
        .doc(userId)
        .collection(postsCollection)
        .get()
        .then(
          (result) {
        List<NGODataHome> posts = [];
        for (DocumentSnapshot post in result.docs) {
          posts.add(NGODataHome.fromSnapshot(post));
        }
        return posts;
      },
    );
  }
  Future<List<NGODataHistory>> getHistory({String userId}) async {
    _firestore
        .collection(collection)
        .doc(userId)
        .collection(historyCollection)
        .get()
        .then(
          (result) {
        List<NGODataHistory> history = [];
        for (DocumentSnapshot contact in result.docs) {
          history.add(NGODataHistory.fromSnapshot(contact));
        }
        return history;
      },
    );
  }
  // void editPost(Map<String, dynamic> data, String id) async {
  //   try {
  //     await _firestore
  //         .collection(collection)
  //         .doc(id)
  //         .collection(historyCollection)
  //         .doc(data['id'])
  //         .set(data);
  //     print('History Added');
  //   } catch (e) {
  //     print('ERROR: ${e.toString()}');
  //   }
  // }
}