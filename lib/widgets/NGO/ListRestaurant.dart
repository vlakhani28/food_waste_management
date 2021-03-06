import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_waste_management/providers/NGO/NGOLoginProvider.dart';
import 'package:food_waste_management/providers/Restaurant/RestaurantLoginProvider.dart';
import 'package:food_waste_management/screens/NGO/NGOHome.dart';
import 'package:food_waste_management/utilities/constants.dart';
import 'package:provider/provider.dart';
import '../CustomSnackBar.dart';
import 'drawer.dart';

class ListRestaurant extends StatefulWidget {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  _ListRestaurantState createState() => _ListRestaurantState();
}

class _ListRestaurantState extends State<ListRestaurant> {
  @override
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<NGOProvider>(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          shadowColor: Colors.white,
          elevation: 0.0,
          title: Text('Hello,' + user.userModel.name,
              style: kTitleStyle.copyWith(fontSize: 25.0, color: primaryColor)),
          centerTitle: true,
        ),
        endDrawer: CustomDrawer(),
        body:NGOList(),
    );
  }
}

class NGOList extends StatelessWidget {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: Color(0xfff5f3f4)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection("restaurant").snapshots(),
              builder: (context,snapshot) {
                if (!snapshot.hasData) {
                  return Text("Loading...");
                }
                List<DocumentSnapshot> documents = snapshot.data.docs;
                return ListV(documents: documents);
              }),
        )
    );
  }
}

class ListV extends StatelessWidget {
  final List<DocumentSnapshot> documents;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  ListV({this.documents});

  List<Widget> _getChildren() {
    List<Widget> children = [];
    documents.forEach((doc) {
      children.add(
        CardItem(
          name: doc['name'],
          projectKey: doc.id,
          firestore: firestore,
          mobileNumber: doc['mobileNumber'],
          id: doc['id']
        ),
      );
    });
    return children;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: _getChildren(),
    );
  }
}



class CardItem extends StatelessWidget {
  CardItem(
      { this.projectKey,  this.name,  this.firestore, this.mobileNumber, this.id});

  final String projectKey;
  final String name;
  final String mobileNumber;
  final String id;
  final FirebaseFirestore firestore;

  @override
  Widget build(BuildContext context) {
    PageStorageKey _projectKey = PageStorageKey('$projectKey');

    return Column(
      key: _projectKey,
      children: <Widget>[
        StreamBuilder(
            stream: firestore
                .collection('restaurant')
                .doc(projectKey)
                .collection('posts')
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) return const Text('Loading...');
              List<DocumentSnapshot> documents = snapshot.data.docs;

              List<Widget> allPosts = [];
              documents.forEach((doc) {
                PageStorageKey _surveyKey = new PageStorageKey('${doc.id}');
                allPosts.add(
                    CreateCard(
                      restName:name,
                     mealType: doc["mealType"],
                      quantity: doc["quantity"],
                      pickUpDay: doc["pickUpDay"],
                      veg: doc["veg"],
                      id: doc["id"],
                      mobileNumber: mobileNumber,
                      restId:id,
                      postId:doc["id"]
                ));
              });
              return Column(children: allPosts);
            })
      ],
    );
  }
}

class CreateCard extends StatelessWidget {
  CreateCard({ this.restName, this.mealType,  this.pickUpDay,  this.quantity,this.veg, this.id, this.mobileNumber,this.restId,this.postId});

  final String mealType;
  final String restName;
  final String pickUpDay;
  final String veg;
  final int quantity;
  final String id;
  final String mobileNumber;
  final String restId;
  final String postId;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<RestaurantProvider>(context);
    final user1 = Provider.of<NGOProvider>(context);
    return Card(
      color: Colors.white,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 20.0,
                  ),
                  Text(
                    restName,
                    style: kTitleStyle.copyWith(color: Colors.black,fontSize: 20.0,fontWeight: FontWeight.w500),
                  )
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: 20.0,
                  ),
                  Text(
                    quantity.toString() + " servings offered",
                    style: kTitleStyle.copyWith(color: Colors.black,fontSize: 18.0,fontWeight: FontWeight.w400),
                  )
                ],
              ),
              SizedBox(height: 15.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Image.asset("assets/images/food_1.png",height: 20,),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        veg,
                        style: kTitleStyle.copyWith(color: Colors.black,fontSize: 15.0,fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Image.asset("assets/images/location.png",height: 20,),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        pickUpDay,
                        style: kTitleStyle.copyWith(color: Colors.black,fontSize: 15.0,fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Image.asset("assets/images/eat.png",height: 20,),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        mealType,
                        style: kTitleStyle.copyWith(color: Colors.black,fontSize: 15.0,fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              SizedBox(
                height: 45,
                width: 300,
                child: ElevatedButton(
                    child: Text(
                      'Accept Donation',
                      style: kTitleStyle.copyWith(fontWeight: FontWeight.w500),
                    ),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        primary: primaryColor,
                        padding: EdgeInsets.all(10.0)),
                    onPressed: (){
                      user.addOnGoing(DateTime.now(), "dishname", id, quantity, veg, 0, "withContainer", pickUpDay, mealType, user1.userModel.name, user1.userModel.uin,user1.userModel.id,restId);
                      user1.addOnGoing(DateTime.now(), "dishname", id, quantity, veg, 0, "withContainer", pickUpDay, mealType, mobileNumber,restName,restId,user1.userModel.id);
                      user.removePost(postId, restId);
                      return Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => NGOHome(),
                        ),
                      );
                    }
                ),
              ),
            ],
          ),
        ),
    );
  }
}

