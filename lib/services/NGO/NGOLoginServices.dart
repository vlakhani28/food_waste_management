import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_waste_management/model/ContactModel.dart';
import 'package:food_waste_management/model/NGO/NGOLoginModel.dart';

class NGOServices {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String collection = "NGO";
  //String contactCollection = "contacts";

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

  // void addContact(Map<String, dynamic> data, String id) async {
  //   try {
  //     await _firestore
  //         .collection(collection)
  //         .doc(id)
  //         .collection(contactCollection)
  //         .doc(data['id'])
  //         .set(data);
  //     print('Contact Added');
  //   } catch (e) {
  //     print('ERROR: ${e.toString()}');
  //   }
  // }
  //
  // void removeContact(String contactId, String id) async {
  //   try {
  //     await _firestore
  //         .collection(collection)
  //         .doc(id)
  //         .collection(contactCollection)
  //         .doc(contactId)
  //         .delete();
  //     print('Contact Removed');
  //   } catch (e) {
  //     print('ERROR: ${e.toString()}');
  //   }
  // }
  //
  // Future<List<ContactModel>> getEmergencyContacs({String userId}) async =>
  //     _firestore
  //         .collection(collection)
  //         .doc(userId)
  //         .collection(contactCollection)
  //         .get()
  //         .then(
  //           (result) {
  //         List<ContactModel> contacts = [];
  //         for (DocumentSnapshot contact in result.docs) {
  //           contacts.add(ContactModel.fromSnapshot(contact));
  //         }
  //         return contacts;
  //       },
  //     );
}