import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_waste_management/model/NGO/NGOHomeModel.dart';
import 'package:food_waste_management/model/Restaurant/RestaurantHomeModel.dart';
import 'package:food_waste_management/model/Restaurant/RestaurantLoginModel.dart';


class UserServices {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String collection = "restaurant";
  String postsCollection = "posts";
  String historyCollection = "history";
  String ongoingCollection = "onGoing";
  String analysisDataCollection ="analysisData";
  String analysisDataDaily ="analysisDataDaily";
  String results = "results";
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
  void addAnalData(Map<String, dynamic> data, String id) async {
    try {
      await _firestore
          .collection(collection)
          .doc(id)
          .collection(analysisDataCollection)
          .doc(data['id'])
          .set(data);
      print('Analysis Added');
    } catch (e) {
      print('ERROR: ${e.toString()}');
    }
  }

  void addOutputData(Map<String, dynamic> data, String id) async {
    try {
      await _firestore
          .collection(collection)
          .doc(id)
          .collection(results)
          .doc(data['id'])
          .set(data);
      print('Result Added');
    } catch (e) {
      print('ERROR: ${e.toString()}');
    }
  }


  void addAnalDataDynamic(Map<String, dynamic> data, String id) async {
    try {
      await _firestore
          .collection(collection)
          .doc(id)
          .collection(analysisDataDaily)
          .doc(data['id'])
          .set(data);
      print('Daily Data Added');
    } catch (e) {
      print('ERROR: ${e.toString()}');
    }
  }
  void addOnGoing(Map<String, dynamic> data, String id) async {
    try {
      await _firestore
          .collection(collection)
          .doc(id)
          .collection(ongoingCollection)
          .doc(data['id'])
          .set(data);
      print('OnGoing Added');
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
  void removeOnGoing(String contactId, String id) async {
    try {
      await _firestore
          .collection(collection)
          .doc(id)
          .collection(ongoingCollection)
          .doc(contactId)
          .delete();
      print('History Removed');
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

  Future<List<NGODataHome>> getNGO() async {
    _firestore.collection("NGO").get().then((querySnapshot) async {
        querySnapshot.docs.forEach((result) async {
          await _firestore
              .collection("NGO")
              .doc(result.id)
              .collection("posts")
              .get()
            .then((querySnapshot) {
          List<NGODataHome> listNGO = [];
          querySnapshot.docs.forEach((result) {
            listNGO.add(NGODataHome.fromSnapshot(result));
          });
        });
      });
    });
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